import 'package:dartz/dartz.dart';
import 'package:fashion_dashboard/core/errors/failures.dart';
import 'package:fashion_dashboard/core/services/main/auth_service.dart';
import 'package:fashion_dashboard/features/auth/domain/repo/auth_repo.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;

  AuthRepoImpl(this.authService);
  @override
  Future<Either<Failure, User>> loginUser(String email, String password) async {
    try {
      final user = await authService.loginUser(email, password);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
