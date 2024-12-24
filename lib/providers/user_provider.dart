import 'dart:io';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/data/repo/main_repo.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class UserProvider extends _$UserProvider {
  final repo = MainRepo();
  @override
  UserModel? build() {
    ref.keepAlive();
    return null;
  }

  Future<bool> signIn(String email, String password) async {
    final user = await repo.signIn(email, password);
    if (user != null) {
      state = user;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String username) async {
    final user = await repo.signUp(email, password, username);
    if (user != null) {
      state = user;
      return true;
    } else {
      return false;
    }
  }

  Future<void> profileImageUpload(UserModel user) async {
    String url = await repo.profileImageUpload(user);
    state = state!.copyWith(image: url);
    ref.invalidate(recipeProviderProvider);
  }

  Future<void> updateUserDetails(
      {required UserModel user,
      String? newUsername,
      String? newPhoneNumber,
      String? newBio}) async {
    await repo.updateUserDetails(
        user: user,
        newUsername: newUsername ?? user.username,
        newPhoneNumber: newPhoneNumber ?? user.phoneNumber,
        newBio: newBio ?? user.bio);
    state = state!.copyWith(
        username: newUsername ?? user.username,
        phoneNumber: newPhoneNumber ?? user.phoneNumber,
        bio: newBio ?? user.bio);
  }

  Future<void> addRecipe(String title, String description, File? image) async {
    await repo.addRecipe(title, description, state!.userID, image);
    print("added");
  }

  Future<UserModel?> getUser(String userID) async {
    return await repo.getUser(userID);
  }
}
