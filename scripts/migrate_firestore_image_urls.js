const admin = require("firebase-admin");
const serviceAccount = require("../fashion-app-7bd03-89cb5b0fc055.json");

const OLD_HOST =
  process.env.OLD_SUPABASE_HOST || "qopnbpevamqddkuqfewm.supabase.co";
const NEW_HOST =
  process.env.NEW_SUPABASE_HOST || "mbinykmmkwfvwmvsbqat.supabase.co";
const NEW_BUCKET = process.env.NEW_BUCKET || "image";
const COLLECTION = process.env.COLLECTION || "products";

function rewriteImageUrl(rawUrl) {
  if (typeof rawUrl !== "string" || rawUrl.trim().length === 0) {
    return rawUrl;
  }

  let parsed;
  try {
    parsed = new URL(rawUrl);
  } catch (_) {
    return rawUrl;
  }

  const oldPathPrefix = "/storage/v1/object/public/";
  if (!parsed.pathname.startsWith(oldPathPrefix)) {
    return rawUrl;
  }

  const rest = parsed.pathname.substring(oldPathPrefix.length);
  const parts = rest.split("/");
  if (parts.length < 2) {
    return rawUrl;
  }

  const objectPath = parts.slice(1).join("/");
  parsed.host = NEW_HOST;
  parsed.pathname = `${oldPathPrefix}${NEW_BUCKET}/${objectPath}`;

  return parsed.toString();
}

async function main() {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });

  const db = admin.firestore();
  const snap = await db.collection(COLLECTION).get();

  let total = 0;
  let updated = 0;
  let unchanged = 0;
  const changedDocs = [];

  const batch = db.batch();

  for (const doc of snap.docs) {
    total += 1;
    const data = doc.data();
    const imageUrl = data.image;

    const nextUrl = rewriteImageUrl(imageUrl);
    const shouldChange =
      typeof imageUrl === "string" &&
      imageUrl.length > 0 &&
      nextUrl !== imageUrl &&
      (imageUrl.includes(OLD_HOST) ||
        imageUrl.includes("/storage/v1/object/public/"));

    if (!shouldChange) {
      unchanged += 1;
      continue;
    }

    batch.update(doc.ref, { image: nextUrl });
    updated += 1;
    changedDocs.push({
      id: doc.id,
      before: imageUrl,
      after: nextUrl,
    });
  }

  if (updated > 0) {
    await batch.commit();
  }

  console.log(
    JSON.stringify(
      {
        collection: COLLECTION,
        total,
        updated,
        unchanged,
        sampleChanges: changedDocs.slice(0, 5),
      },
      null,
      2,
    ),
  );
}

main().catch((error) => {
  console.error("Migration failed:", error);
  process.exit(1);
});
