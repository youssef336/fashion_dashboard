import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User> loginUser(String email, String password);
}
