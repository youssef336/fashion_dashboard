import 'package:fashion_dashboard/core/errors/exception.dart';
import 'package:fashion_dashboard/core/services/main/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements AuthService {
  final auth = FirebaseAuth.instance;
  late User clinet;
  @override
  Future<User> loginUser(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      clinet = credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw CustomException(
          message:
              " User with this email doesn't exist, please create an account",
        );
      } else if (e.code == 'wrong-password') {
        throw CustomException(
          message:
              "Incorrect password, please check your password and try again",
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: "Please check your internet connection");
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: "Please enter a valid email address");
      } else {
        throw CustomException(
          message: "An error occurred while logging in, please try again later",
        );
      }
    }
    return clinet;
  }
}

bool isUserLoggedIn() {
  return FirebaseAuth.instance.currentUser != null;
}
