import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/data/repo/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/data/repo/fireStore_repo.dart';

class MainRepo {
  final AuthRepo _authRepo = AuthRepo();
  final FirestoreRepo _firestoreRepo = FirestoreRepo();

  // Sign up with email and password, then create a Firestore document for the user
  Future<User?> signUp(
      String email, String password, String displayName) async {
    User? user = await _authRepo.signUp(email, password, displayName);
    if (user != null) {
      UserModel userModel = UserModel(
        userID: user.uid,
        email: user.email ?? '',
        username: user.displayName ?? '',
        phoneNumber: '',
        recipes: {},
      );
      await _firestoreRepo.addUser('users', userModel.toMap());
    }
    return user;
  }

  // Sign in with email and password, then retrieve the Firestore document for the user
  Future<Map<String, dynamic>?> signIn(String email, String password) async {
    User? user = await _authRepo.signIn(email, password);
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestoreRepo.getUser('users', user.uid);
      return userDoc.data() as Map<String, dynamic>?;
    }
    return null;
  }
}
