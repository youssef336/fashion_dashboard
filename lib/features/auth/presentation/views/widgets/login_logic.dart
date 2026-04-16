import 'package:fashion_dashboard/core/helper_functions/build_error_bar.dart';
import 'package:fashion_dashboard/core/widgets/custom_buttom.dart';
import 'package:fashion_dashboard/core/widgets/custom_text_feild.dart';
import 'package:fashion_dashboard/features/auth/presentation/manager/cubits/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginLogic extends StatefulWidget {
  const LoginLogic({super.key});

  @override
  State<LoginLogic> createState() => _LoginLogicState();
}

class _LoginLogicState extends State<LoginLogic> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static const String demoEmail = 'gg@gmail.com';
  static const String demoPassword = '123456789';

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email;
  String? password;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              emailController.text = demoEmail;
              passwordController.text = demoPassword;
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE6E9E9)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Demo email: gg@gmail.com',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Demo password: 123456789',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6),
                  Text('Tap here to auto-fill credentials'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomTextFormFeild(
            controller: emailController,
            textInputType: TextInputType.emailAddress,
            hintText: 'Email',
            maxLines: 1,
            obscureText: false,
            onSaved: (p0) {
              email = p0;
            },
          ),
          const SizedBox(height: 20),
          CustomTextFormFeild(
            controller: passwordController,
            textInputType: TextInputType.visiblePassword,
            hintText: 'Password',
            maxLines: 1,

            onSaved: (p0) {
              password = p0;
            },
          ),
          const SizedBox(height: 60),
          CustomButtom(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                if (email == demoEmail && password == demoPassword) {
                  context.read<LoginCubit>().loginUser(email!, password!);
                } else {
                  showErrorBar(context, "Not Manager Account");
                }
              } else {
                setState(() {
                  autovalidateMode = AutovalidateMode.always;
                });
              }
            },
            text: 'Login',
          ),
        ],
      ),
    );
  }
}
