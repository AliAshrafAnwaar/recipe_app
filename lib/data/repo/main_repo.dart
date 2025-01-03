import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/data/model/recipe_model.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/data/repo/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/data/repo/fireStore_repo.dart';
import 'package:recipe_app/data/repo/storage_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        favourites: {},
        phoneNumber: '',
        bio: '',
        image: '',
        recipes: {},
      );
      await _firestoreRepo.addUser('users', userModel.toMap());

      // Save the user token in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userToken',
          user.uid); // Save the token (or any other unique identifier)

      return userModel;
    }
    return null;
  }

  // Sign in with email and password, then retrieve the Firestore document for the user
  Future<UserModel?> signIn(String email, String password) async {
    User? user = await _authRepo.signIn(email, password);
    if (user != null) {
      // Fetch the user document from Firestore
      DocumentSnapshot userDoc =
          await _firestoreRepo.getUser('users', user.uid);

      // Create a UserModel from the data
      final UserModel userModel =
          UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

      // Save the user token in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userToken',
          user.uid); // Save the token (or any other unique identifier)

      // Return the UserModel
      return userModel;
    }
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    // Sign out from the authentication repository
    await _authRepo.signOut();

    // Remove the user token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken'); // Remove the saved token

    // Optionally, you can clear all preferences if needed
    // await prefs.clear();
  }

  Future<String> profileImageUpload(UserModel user) async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File compressedFile = await _storageRepo.compressImageToTargetSize(
          File(pickedFile.path), 400);
      String? url = await _storageRepo.uploadImage(compressedFile, 'users/');
      UserModel modUser = user.copyWith(image: url);
      await _firestoreRepo.updateUser('users', modUser.userID, modUser.toMap());
      return url;
    }
    return user.image;
  }

  Future<String> postImageUpload(File? image) async {
    if (image != null) {
      File compressedFile =
          await _storageRepo.compressImageToTargetSize(image, 400);
      String? url = await _storageRepo.uploadImage(compressedFile, 'Recipes/');
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

  Future<Set<RecipeModel>> getCollection({List<String>? recipeIDs}) async {
    final json =
        await _firestoreRepo.getCollection('recipes', recipeIDs: recipeIDs);
    final data = json.docs
        .map((doc) => RecipeModel.fromMap(doc.data() as Map<String, dynamic>))
        .toSet();
    return data;
  }

  Future<void> addRecipe(
      String title, String description, String userID, File? image) async {
    RecipeModel recipe = RecipeModel(
      recipeID: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      description: description,
      ratings: [],
      likes: {},
      comments: [],
      favourites: {},
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

    final modifiedUser =
        user.copyWith(recipes: {recipe.recipeID, ...user.recipes});

    _firestoreRepo.updateUser('users', userID, modifiedUser.toMap());
  }

  Future<void> deleteRecipe(String signedInUser, String recipeID) async {
    _firestoreRepo.deleteRecipe(signedInUser, recipeID);
  }

  Future<UserModel?> getUser(String userID) async {
    final user = await _firestoreRepo.getUser('users', userID).then((result) {
      UserModel user = UserModel.fromMap(result.data() as Map<String, dynamic>);
      return user;
    });
    return user;
  }

  Future<void> updateRecipe({
    required String recipeID,
    String? actionUser,
    String? title,
    String? description,
    File? image,
    double? rating,
    String? userLike,
    String? userDisLike,
    String? favouriteRecipeID,
    String? unFavouriteRecipeID,
  }) async {
    // title and descrpition
    if (title != null && description != null) {
      await _firestoreRepo.editRecipe(recipeID, title, description);
    }
    // Add user like to the recipe if provided
    if (userLike != null) {
      await _firestoreRepo.addUserLikeToRecipe(recipeID, userLike);
    }

    // Remove user like from the recipe if provided
    if (userDisLike != null) {
      await _firestoreRepo.deleteUserLikeFromRecipe(recipeID, userDisLike);
    }

    // Add recipe to user's favourites if provided
    if (favouriteRecipeID != null) {
      await _firestoreRepo.addRecipeToFavourites(
          actionUser!, favouriteRecipeID);
    }

    // Remove recipe from user's favourites if provided
    if (unFavouriteRecipeID != null) {
      await _firestoreRepo.removeRecipeFromFavourites(
          actionUser!, unFavouriteRecipeID);
    }

    if (rating != null) {
      await _firestoreRepo.addRecipeRatingToUser(recipeID, rating);
    }
  }

  //search
  Future<Set<RecipeModel>> searchRecipesByTitle(String title) async {
    final QuerySnapshot querySnapshot =
        await _firestoreRepo.searchByTitle('recipes', title);
    final Set<RecipeModel> recipes = querySnapshot.docs.map((doc) {
      return RecipeModel.fromMap(doc.data() as Map<String, dynamic>);
    }).toSet();
    return recipes;
  }
}
