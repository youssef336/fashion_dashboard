import 'package:dartz/dartz.dart';
import 'package:fashion_dashboard/core/errors/failures.dart';
import 'package:fashion_dashboard/core/repo/customer_pay/customer_pay_repo.dart';
import 'package:fashion_dashboard/core/services/main/database_service.dart';
import 'package:fashion_dashboard/core/utils/backendpoints.dart';

class CustomerPayRepoImpl implements CustomerPayRepo {
  final DatabaseService databaseService;
  CustomerPayRepoImpl(this.databaseService);
  @override
  Future<Either<Failure, void>> updateCustomerPay(bool ispay) async {
    try {
      await databaseService.updateData(
        path: BackEndEndpoints.pay,
        documentId: '1',
        data: {'isPay': ispay},
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
