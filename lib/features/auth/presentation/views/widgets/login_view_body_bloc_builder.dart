import 'package:fashion_dashboard/core/helper_functions/build_error_bar.dart';
import 'package:fashion_dashboard/core/widgets/custom_modal_progress_hub.dart';
import 'package:fashion_dashboard/features/auth/presentation/manager/cubits/login/login_cubit.dart';
import 'package:fashion_dashboard/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:fashion_dashboard/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewBodyBlocBuilder extends StatelessWidget {
  const LoginViewBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        return CustomModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          child: const LoginViewBody(),
        );
      },
      listener: (BuildContext context, LoginState state) {
        if (state is LoginSuccess) {
          Navigator.pushNamed(context, HomeView.routeName);
        }
        if (state is LoginError) {
          showErrorBar(context, state.message);
        }
      },
    );
  }
}
