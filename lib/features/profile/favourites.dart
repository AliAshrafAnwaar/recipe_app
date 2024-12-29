import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/data/model/recipe_model.dart';
import 'package:recipe_app/features/home/widgets/recipe_card.dart';
import 'package:recipe_app/providers/user_provider.dart';

class Favourites extends ConsumerStatefulWidget {
  const Favourites({super.key});

  @override
  ConsumerState<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends ConsumerState<Favourites> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProviderProvider)!;

    List<String> recipeIDs = user.favourites.toList();

    Future<Set<RecipeModel>> recipesFuture;

    if (recipeIDs.isNotEmpty) {
      // Fetch recipes as a Future
      recipesFuture = ref
          .read(userProviderProvider.notifier)
          .getCollection(recipeIDs: recipeIDs);
    } else {
      // Initialize an empty set of recipes
      recipesFuture = Future.value(<RecipeModel>{});
    }

    return Scaffold(
      backgroundColor: AppColors.secondaryText,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryText,
        title: Text(
          'Favourites',
          style: AppTextStyles.primaryTextStyle,
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.mainColor,
        onRefresh: () async {
          await ref
              .read(userProviderProvider.notifier)
              .sharedPreferenceLogin(user.userID);
        },
        child: FutureBuilder<Set<RecipeModel>>(
          future: recipesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No Recipes'),
                  ],
                ),
              );
            }

            // Data is successfully retrieved
            final recipes = snapshot.data!.toList();

            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index]; // Accessing set elements
                return RecipeCard(
                  recipe: recipe,
                  signeduserFavourites: true,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
