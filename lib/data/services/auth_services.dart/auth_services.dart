import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_app/core/constants/app_colors.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the user's display name
      await userCredential.user?.updateDisplayName(username);
      await userCredential.user?.reload(); // Reload to apply changes
      User? updatedUser = _auth.currentUser;

      Fluttertoast.showToast(
        msg: '$username created successfully',
        toastLength: Toast.LENGTH_SHORT, // Duration: SHORT or LONG
        gravity: ToastGravity.BOTTOM, // Position: BOTTOM, CENTER, or TOP
        backgroundColor: AppColors.mainColor, // Background color
        textColor: AppColors.secondaryText, // Text color
        fontSize: 16.0, // Text size
      );

      return updatedUser;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT, // Duration: SHORT or LONG
        gravity: ToastGravity.BOTTOM, // Position: BOTTOM, CENTER, or TOP
        backgroundColor: AppColors.mainColor, // Background color
        textColor: AppColors.secondaryText, // Text color
        fontSize: 16.0, // Text size
      );
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Fluttertoast.showToast(
        msg: '${userCredential.user!.displayName} signed successfully',
        toastLength: Toast.LENGTH_SHORT, // Duration: SHORT or LONG
        gravity: ToastGravity.BOTTOM, // Position: BOTTOM, CENTER, or TOP
        backgroundColor: AppColors.mainColor, // Background color
        textColor: AppColors.secondaryText, // Text color
        fontSize: 16.0, // Text size
      );
      return userCredential.user;
    } catch (e) {
      Fluttertoast.showToast(
        msg: '$e',
        toastLength: Toast.LENGTH_SHORT, // Duration: SHORT or LONG
        gravity: ToastGravity.BOTTOM, // Position: BOTTOM, CENTER, or TOP
        backgroundColor: AppColors.mainColor, // Background color
        textColor: AppColors.secondaryText, // Text color
        fontSize: 16.0, // Text size
      );
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  // Get current user
  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
