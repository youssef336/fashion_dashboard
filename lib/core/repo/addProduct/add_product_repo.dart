import 'package:dartz/dartz.dart';
import 'package:fashion_dashboard/core/entities/product_entity.dart';
import 'package:fashion_dashboard/core/errors/failures.dart';

abstract class AddProductRepo {
  Future<Either<Failure, void>> addProduct(ProductEntity productEntity);
}
