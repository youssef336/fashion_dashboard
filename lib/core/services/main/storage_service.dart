import 'dart:io';

abstract class StorageService {
  Future<String> uploadfile(File file, String path);
}
