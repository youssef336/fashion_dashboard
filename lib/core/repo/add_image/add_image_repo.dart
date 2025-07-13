import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fashion_dashboard/core/errors/failures.dart';

abstract class AddImageRepo {
  Future<Either<Failure, String>> addImage(File? image);
  Future<Either<Failure, void>> deleteImage(String path);
}
