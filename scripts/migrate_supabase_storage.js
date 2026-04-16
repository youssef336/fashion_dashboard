const fs = require("fs");
const path = require("path");

const SUPABASE_URL =
  process.env.SUPABASE_URL || "https://mbinykmmkwfvwmvsbqat.supabase.co";
const SUPABASE_ANON_KEY =
  process.env.SUPABASE_ANON_KEY ||
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1iaW55a21ta3dmdndtdnNicWF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzYzNjEzMjYsImV4cCI6MjA5MTkzNzMyNn0.txGuh4lQw-y_3xG4G_DfPuOcv9092eliy_h7DjwBYjk";
const BUCKET_NAME = process.env.BUCKET_NAME || "image";
const BACKUP_FOLDER_PATH =
  process.env.BACKUP_FOLDER_PATH || path.resolve("assets/images");

function contentTypeFor(filePath) {
  const ext = path.extname(filePath).toLowerCase();
  switch (ext) {
    case ".jpg":
    case ".jpeg":
      return "image/jpeg";
    case ".png":
      return "image/png";
    case ".webp":
      return "image/webp";
    case ".gif":
      return "image/gif";
    case ".svg":
      return "image/svg+xml";
    case ".bmp":
      return "image/bmp";
    case ".tif":
    case ".tiff":
      return "image/tiff";
    case ".avif":
      return "image/avif";
    default:
      return "application/octet-stream";
  }
}

function encodeObjectPath(objectPath) {
  return objectPath
    .split("/")
    .map((part) => encodeURIComponent(part))
    .join("/");
}

function toPublicUrl(bucket, objectPath) {
  return `${SUPABASE_URL}/storage/v1/object/public/${encodeURIComponent(bucket)}/${encodeObjectPath(objectPath)}`;
}

async function supabaseFetch(urlPath, options = {}) {
  const url = `${SUPABASE_URL}${urlPath}`;
  const headers = {
    apikey: SUPABASE_ANON_KEY,
    Authorization: `Bearer ${SUPABASE_ANON_KEY}`,
    ...options.headers,
  };
  return fetch(url, { ...options, headers });
}

function walkFiles(rootDir) {
  const files = [];

  function walk(currentDir) {
    const entries = fs.readdirSync(currentDir, { withFileTypes: true });
    for (const entry of entries) {
      const fullPath = path.join(currentDir, entry.name);
      if (entry.isDirectory()) {
        walk(fullPath);
        continue;
      }
      if (entry.name === ".emptyFolderPlaceholder") {
        continue;
      }
      files.push(fullPath);
    }
  }

  walk(rootDir);
  return files;
}

async function ensureBucket(bucket) {
  const details = {
    existed: false,
    created: false,
    error: null,
  };

  const checkRes = await supabaseFetch(
    `/storage/v1/bucket/${encodeURIComponent(bucket)}`,
  );
  if (checkRes.ok) {
    details.existed = true;
    return details;
  }

  const checkBody = await checkRes.text();
  const looksLikeMissingBucket =
    checkRes.status === 404 ||
    (checkRes.status === 400 &&
      checkBody.toLowerCase().includes("bucket not found"));

  if (!looksLikeMissingBucket) {
    details.error = {
      step: "check_bucket",
      status: checkRes.status,
      body: checkBody,
    };
    return details;
  }

  const createRes = await supabaseFetch("/storage/v1/bucket", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      id: bucket,
      name: bucket,
      public: true,
    }),
  });

  if (createRes.ok) {
    details.created = true;
    return details;
  }

  details.error = {
    step: "create_bucket",
    status: createRes.status,
    body: await createRes.text(),
  };
  return details;
}

async function applyPolicies(bucket) {
  const sql = `
create policy if not exists "${bucket}_insert_anon"
on storage.objects
for insert
to anon
with check (bucket_id = '${bucket}');

create policy if not exists "${bucket}_select_public"
on storage.objects
for select
to public
using (bucket_id = '${bucket}');

create policy if not exists "${bucket}_update_anon"
on storage.objects
for update
to anon
using (bucket_id = '${bucket}')
with check (bucket_id = '${bucket}');
`;

  const res = await supabaseFetch("/rest/v1/rpc/exec_sql", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Prefer: "params=single-object",
    },
    body: JSON.stringify({ sql }),
  });

  if (res.ok) {
    return { applied: true, error: null };
  }

  return {
    applied: false,
    error: {
      step: "apply_policies",
      status: res.status,
      body: await res.text(),
    },
  };
}

async function uploadFile(bucket, rootDir, absoluteFilePath) {
  const relativePath = path
    .relative(rootDir, absoluteFilePath)
    .split(path.sep)
    .join("/");
  const objectPath = relativePath;
  const buffer = fs.readFileSync(absoluteFilePath);
  const contentType = contentTypeFor(absoluteFilePath);

  const res = await supabaseFetch(
    `/storage/v1/object/${encodeURIComponent(bucket)}/${encodeObjectPath(objectPath)}`,
    {
      method: "POST",
      headers: {
        "Content-Type": contentType,
        "x-upsert": "true",
      },
      body: buffer,
    },
  );

  if (!res.ok) {
    return {
      success: false,
      objectPath,
      contentType,
      status: res.status,
      body: await res.text(),
      publicUrl: toPublicUrl(bucket, objectPath),
    };
  }

  return {
    success: true,
    objectPath,
    contentType,
    status: res.status,
    publicUrl: toPublicUrl(bucket, objectPath),
  };
}

async function verifyHead(publicUrl) {
  const res = await fetch(publicUrl, { method: "HEAD" });
  const contentType = res.headers.get("content-type") || "";

  let cacheBust = null;
  if (!contentType.startsWith("image/")) {
    const bustedUrl = `${publicUrl}${publicUrl.includes("?") ? "&" : "?"}t=${Date.now()}`;
    const busted = await fetch(bustedUrl, { method: "HEAD" });
    cacheBust = {
      url: bustedUrl,
      status: busted.status,
      contentType: busted.headers.get("content-type") || "",
    };
  }

  return {
    url: publicUrl,
    status: res.status,
    contentType,
    cacheBust,
  };
}

async function main() {
  const result = {
    config: {
      supabaseUrl: SUPABASE_URL,
      bucket: BUCKET_NAME,
      backupFolderPath: BACKUP_FOLDER_PATH,
    },
    bucket: null,
    policies: null,
    upload: {
      total: 0,
      success: 0,
      failed: 0,
      failedNames: [],
      uploaded: [],
    },
    sampleHeadChecks: [],
    blockers: [],
  };

  if (!fs.existsSync(BACKUP_FOLDER_PATH)) {
    result.blockers.push({
      step: "backup_path",
      message: `Backup folder not found: ${BACKUP_FOLDER_PATH}`,
    });
    console.log(JSON.stringify(result, null, 2));
    process.exit(1);
  }

  result.bucket = await ensureBucket(BUCKET_NAME);
  if (result.bucket.error) {
    result.blockers.push(result.bucket.error);
  }

  result.policies = await applyPolicies(BUCKET_NAME);
  if (result.policies.error) {
    result.blockers.push(result.policies.error);
  }

  const files = walkFiles(BACKUP_FOLDER_PATH);
  result.upload.total = files.length;

  for (const file of files) {
    const uploadRes = await uploadFile(BUCKET_NAME, BACKUP_FOLDER_PATH, file);
    if (!uploadRes.success) {
      result.upload.failed += 1;
      result.upload.failedNames.push(uploadRes.objectPath);
      result.blockers.push({
        step: "upload_file",
        objectPath: uploadRes.objectPath,
        status: uploadRes.status,
        body: uploadRes.body,
      });
      continue;
    }

    result.upload.success += 1;
    result.upload.uploaded.push(uploadRes);
  }

  const sample = result.upload.uploaded.slice(0, 3);
  for (const item of sample) {
    result.sampleHeadChecks.push(await verifyHead(item.publicUrl));
  }

  console.log(JSON.stringify(result, null, 2));
}

main().catch((error) => {
  console.error("Migration script failed:", error);
  process.exit(1);
});
