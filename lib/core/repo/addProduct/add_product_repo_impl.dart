import 'package:dartz/dartz.dart';
import 'package:fashion_dashboard/core/entities/product_entity.dart';
import 'package:fashion_dashboard/core/errors/failures.dart';
import 'package:fashion_dashboard/core/models/product_model.dart';
import 'package:fashion_dashboard/core/repo/addProduct/add_product_repo.dart';
import 'package:fashion_dashboard/core/services/main/database_service.dart';
import 'package:fashion_dashboard/core/utils/backendpoints.dart';

class AddProductRepoImpl implements AddProductRepo {
  final DatabaseService databaseService;

  AddProductRepoImpl(this.databaseService);
  @override
  Future<Either<Failure, void>> addProduct(ProductEntity productEntity) async {
    try {
      await databaseService.addData(
        documentId: productEntity.docmentId,
        path: BackEndEndpoints.addProduct,
        data: ProductModel.fromEntity(productEntity).tojson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
