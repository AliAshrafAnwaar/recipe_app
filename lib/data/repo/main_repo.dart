import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/data/model/recipe_model.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/data/repo/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/data/repo/fireStore_repo.dart';
import 'package:recipe_app/data/repo/storage_repo.dart';

class MainRepo {
  final AuthRepo _authRepo = AuthRepo();
  final FirestoreRepo _firestoreRepo = FirestoreRepo();
  final StorageRepo _storageRepo = StorageRepo();
  final picker = ImagePicker();

  // Sign up with email and password, then create a Firestore document for the user
  Future<UserModel?> signUp(
      String email, String password, String displayName) async {
    User? user = await _authRepo.signUp(email, password, displayName);
    if (user != null) {
      UserModel userModel = UserModel(
        userID: user.uid,
        email: user.email ?? '',
        username: user.displayName ?? '',
        phoneNumber: '',
        bio: '',
        image: '',
        recipes: {},
      );
      await _firestoreRepo.addUser('users', userModel.toMap());

      return userModel;
    }
    return null;
  }

  // Sign in with email and password, then retrieve the Firestore document for the user
  Future<UserModel?> signIn(String email, String password) async {
    User? user = await _authRepo.signIn(email, password);
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestoreRepo.getUser('users', user.uid);
      final UserModel userModel =
          UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      return userModel;
    }
    return null;
  }

  Future<String> profileImageUpload(UserModel user) async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String? url =
          await _storageRepo.uploadImage(File(pickedFile.path), 'users/');
      UserModel modUser = user.copyWith(image: url);
      await _firestoreRepo.updateUser('users', modUser.userID, modUser.toMap());
      return url;
    }
    return user.image;
  }

  Future<String> postImageUpload(File? image) async {
    if (image != null) {
      String? url = await _storageRepo.uploadImage(image, 'Recipes/');
      return url;
    }
    return '';
  }

  // Update user's username and phone number
  Future<void> updateUserDetails(
      {required UserModel user,
      String? newUsername,
      String? newPhoneNumber,
      String? newBio}) async {
    UserModel updatedUser = user.copyWith(
        username: newUsername ?? user.username,
        phoneNumber: newPhoneNumber ?? user.phoneNumber,
        bio: newBio ?? user.bio);
    await _firestoreRepo.updateUser(
        'users', updatedUser.userID, updatedUser.toMap());
  }

  Future<Set<RecipeModel>> getCollection() async {
    final json = await _firestoreRepo.getCollection('recipes');
    final data = json.docs
        .map((doc) => RecipeModel.fromMap(doc.data() as Map<String, dynamic>))
        .toSet();
    for (RecipeModel recipe in data) {
      print(recipe.date);
    }
    return data;
  }

  Future<void> addRecipe(
      String title, String description, String userID, File? image) async {
    RecipeModel recipe = RecipeModel(
      recipeID: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      description: description,
      userID: userID,
      imageLink: await postImageUpload(image),
      date: DateTime.now(),
    );
    final data = recipe.toMap();
    await _firestoreRepo.addRecipe('recipes', data);

    final user = await _firestoreRepo.getUser('users', userID).then((result) {
      UserModel user = UserModel.fromMap(result.data() as Map<String, dynamic>);
      return user;
    });

    final modifiedUser = user.copyWith(recipes: {recipe, ...user.recipes});
    print(user);

    _firestoreRepo.updateUser('users', userID, modifiedUser.toMap());
  }

  Future<UserModel?> getUser(String userID) async {
    final user = await _firestoreRepo.getUser('users', userID).then((result) {
      UserModel user = UserModel.fromMap(result.data() as Map<String, dynamic>);
      return user;
    });
    return user;
  }
}
