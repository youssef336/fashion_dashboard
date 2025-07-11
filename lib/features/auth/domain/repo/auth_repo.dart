import 'package:dartz/dartz.dart';

import 'package:fashion_dashboard/core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> loginUser(String email, String password);
}
