import 'dart:io';
import 'package:recipe_app/data/model/recipe_model.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/data/repo/main_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_provider.g.dart';

@riverpod
class RecipeProvider extends _$RecipeProvider {
  MainRepo repo = MainRepo();
  @override
  Set<RecipeModel>? build() {
    ref.keepAlive(); // Ensure the state is kept alive
    getRecipes();
    return {};
  }

  Future<void> getRecipes() async {
    final recipes = await repo.getCollection();
    state = recipes;
  }

  Future<UserModel?> getUser(String userID) async {
    return await repo.getUser(userID);
  }
}
