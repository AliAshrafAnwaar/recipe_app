import 'package:recipe_app/data/model/recipe_model.dart';
import 'package:recipe_app/data/repo/main_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
class SearchProvider extends _$SearchProvider {
  MainRepo repo = MainRepo();

  @override
  List<RecipeModel> build() {
    ref.keepAlive();
    return [];
  }

  Future<void> searchRecipesByTitle(String title) async {
    final Set<RecipeModel> searchedRecipes =
        await repo.searchRecipesByTitle(title);
    state = searchedRecipes.toList();
  }
}
