// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:fashion_dashboard/core/services/main/storage_service.dart';
import 'package:fashion_dashboard/secret_conatant.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as b;

class SupabaseStorage implements StorageService {
  final Supabase _supabase = Supabase.instance;

  @override
  Future<String> uploadfile(File file, String path) async {
    final String fileName = b.basename(file.path);
    final String objectPath = "$path/$fileName";
    final String contentType =
        lookupMimeType(file.path) ?? 'application/octet-stream';

    await _supabase.client.storage
        .from(KsupabaseBucket)
        .upload(
          objectPath,
          file,
          fileOptions: FileOptions(contentType: contentType, upsert: true),
        );

    final String publicUrl = _supabase.client.storage
        .from(KsupabaseBucket)
        .getPublicUrl(objectPath);

    return publicUrl;
  }

  @override
  Future<void> deleteFile(String path) async {
    await _supabase.client.storage.from(KsupabaseBucket).remove([path]);
  }
}
