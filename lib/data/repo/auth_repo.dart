import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/data/services/auth_services.dart/auth_services.dart';

class AuthRepo {
  final AuthServices _authService = AuthServices();

  // Sign up with email and password
  Future<User?> signUp(
      String email, String password, String displayName) async {
    return await _authService.signUpWithEmailAndPassword(
        email, password, displayName);
  }

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    return await _authService.signInWithEmailAndPassword(email, password);
  }

  // Sign out
  Future<void> signOut() async {
    await _authService.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _authService.getCurrentUser();
  }
}
