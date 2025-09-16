import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fashion_dashboard/core/errors/failures.dart';
import 'package:fashion_dashboard/core/repo/add_image/add_image_repo.dart';
import 'package:fashion_dashboard/core/services/main/storage_service.dart';
import 'package:fashion_dashboard/core/utils/backendpoints.dart';

class AddImageRepoImpl implements AddImageRepo {
  final StorageService storageService;

  AddImageRepoImpl(this.storageService);
  @override
  Future<Either<Failure, String>> addImage(File? image) async {
    try {
      final url = await storageService.uploadfile(
        image!,
        BackEndEndpoints.addProduct,
      );
      return Right(url);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteImage(String path) async {
    try {
      await storageService.deleteFile(path);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
