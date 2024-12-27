import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/features/home/recipe_details.dart';
import 'package:recipe_app/features/shared_widgets/styled_textField.dart';
import 'package:recipe_app/providers/search_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryText,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.secondaryText,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                _buildSearchBar(),
                const Divider(
                  color: AppColors.mainColor,
                  height: 10,
                ),
                _buildRecipeList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: StyledTextField(
              controller: _searchController,
              hint: 'Search for recipe',
              icon: Icons.food_bank,
            ),
          ),
          IconButton(
            onPressed: () {
              final title = _searchController.text;
              ref
                  .read(searchProviderProvider.notifier)
                  .searchRecipesByTitle(title);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeList() {
    return Expanded(
      child: Consumer(
        builder: (context, ref, child) {
          final recipes = ref.watch(searchProviderProvider);

          if (_searchController.text.isEmpty) {
            return const SizedBox();
          }

          if (recipes.isEmpty) {
            return const Center(child: Text('No recipes found'));
          }

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return _buildRecipeTile(recipe);
            },
          );
        },
      ),
    );
  }

  Widget _buildRecipeTile(recipe) {
    return InkWell(
      onTap: () async {
        final user = await ref
            .read(userProviderProvider.notifier)
            .getUser(recipe.userID) as UserModel;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetails(user: user, recipe: recipe),
          ),
        );
      },
      child: ListTile(
        title: Text(recipe.title),
        subtitle: Text(
          recipe.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
