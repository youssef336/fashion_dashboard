import 'package:dartz/dartz.dart';
import 'package:fashion_dashboard/core/errors/failures.dart';
import 'package:fashion_dashboard/core/services/main/database_service.dart';

abstract class FetchProductRepo {
  Future<Either<Failure, dynamic>> fetchProduct();
  Future<Either<Failure, void>> deleteProduct(String id);
}
