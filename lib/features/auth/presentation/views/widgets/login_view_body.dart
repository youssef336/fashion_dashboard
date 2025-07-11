import 'package:fashion_dashboard/features/auth/presentation/views/widgets/login_logic.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: LoginLogic()),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
