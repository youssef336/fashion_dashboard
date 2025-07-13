import 'dart:io';

abstract class StorageService {
  Future<String> uploadfile(File file, String path);
  Future<void> deleteFile(String path);
}
