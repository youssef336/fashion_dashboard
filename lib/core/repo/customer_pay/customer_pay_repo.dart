import 'package:dartz/dartz.dart';
import 'package:fashion_dashboard/core/errors/failures.dart';

abstract class CustomerPayRepo {
  Future<Either<Failure, void>> updateCustomerPay(bool ispay);
}
