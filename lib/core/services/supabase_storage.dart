import 'dart:io';

import 'package:fashion_dashboard/core/services/main/storage_service.dart';
import 'package:fashion_dashboard/secret_conatant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as b;

class SupabaseStorage implements StorageService {
  final Supabase _supabase = Supabase.instance;
  @override
  Future<String> uploadfile(File file, String path) async {
    String fileName = b.basename(file.path);
    String extensionName = b.extension(file.path);
    await _supabase.client.storage
        .from(KsupabaseBucket)
        .upload("$path/$fileName$extensionName", file);
    final String publicUrl = _supabase.client.storage
        .from(KsupabaseBucket)
        .getPublicUrl("$path/$fileName$extensionName");

    return publicUrl;
  }
}
