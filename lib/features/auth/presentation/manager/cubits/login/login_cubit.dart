// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:fashion_dashboard/features/auth/domain/repo/auth_repo.dart';

import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo loginRepo;
  LoginCubit(this.loginRepo) : super(LoginInitial());

  Future<void> loginUser(String email, String password) async {
    emit(LoginLoading());
    final result = await loginRepo.loginUser(email, password);
    result.fold(
      (l) => emit(LoginError(message: l.message)),
      (r) => emit(LoginSuccess()),
    );
  }
}
