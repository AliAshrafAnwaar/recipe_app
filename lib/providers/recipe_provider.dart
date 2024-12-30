import 'dart:io';
import 'package:recipe_app/data/model/recipe_model.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/data/repo/main_repo.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_provider.g.dart';

@riverpod
class RecipeProvider extends _$RecipeProvider {
  final MainRepo _repo = MainRepo();
  @override
  Set<RecipeModel>? build() {
    getRecipes();
    return {};
  }

  Future<void> getRecipes() async {
    final recipes = await _repo.getCollection();
    state = recipes;
    ref.notifyListeners();
  }

  Future<void> deleteRecipe(String signedInUser, String recipeID) async {
    await _repo.deleteRecipe(signedInUser, recipeID);
    await ref
        .read(userProviderProvider.notifier)
        .sharedPreferenceLogin(signedInUser);
    await getRecipes();
  }

  // Get a user's details
  Future<UserModel?> getUser(String userID) async {
    return await _repo.getUser(userID);
  }

  // rate a recipe
  Future<void> updateRecipe({
    required String recipeID,
    required String signedUser,
    String? title,
    String? description,
    File? image,
    double? rating,
    String? userLikeID,
    String? userDisLikeID,
    String? favouriteRecipeID,
    String? unfavouriteRecipeID,
  }) async {
    await _repo.updateRecipe(
        recipeID: recipeID,
        actionUser: signedUser,
        rating: rating,
        title: title,
        description: description,
        userLike: userLikeID,
        userDisLike: userDisLikeID,
        favouriteRecipeID: favouriteRecipeID,
        unFavouriteRecipeID: unfavouriteRecipeID);
    await ref.read(userProviderProvider.notifier).sharedPreferenceLogin(
        signedUser,
        isFav: (unfavouriteRecipeID != null) ? true : null);

    await getRecipes();
  }
}
