import 'package:dartz/dartz.dart';
import 'package:fashion_dashboard/core/errors/failures.dart';

abstract class FetchProductRepo {
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchProduct();
  Future<Either<Failure, void>> deleteProduct(String id);
}
