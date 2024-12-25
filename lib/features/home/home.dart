import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/app_router.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/features/home/widgets/create_recipe_container.dart';
import 'package:recipe_app/features/home/widgets/recipe_card.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/shared_preference_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the sharedPreferencesProvider
    final prefsAsync = ref.watch(sharedPreferencesProvider);

    return prefsAsync.when(
      data: (prefs) {
        // Get the userToken from SharedPreferences
        final userToken = prefs.getString('userToken');

        // Delaying navigation to prevent navigation during build phase
        if (userToken == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            GoRouter.of(context).go(AppRouter.signIn);
          });
        }

        // Fetch user and recipes
        UserModel? user = ref.watch(userProviderProvider);

        // Check if user is null and navigate accordingly
        if (user == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            GoRouter.of(context).go(AppRouter.signIn);
          });
          return const SizedBox
              .shrink(); // Return an empty widget while navigating
        }

        final recipes = ref.watch(recipeProviderProvider)!.toList();
        recipes.sort((a, b) => b.date.compareTo(a.date));

        return Container(
          color: AppColors.secondaryText,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.secondaryText,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    appBarRow(context),
                    profilePostRow(context, user),
                    Flexible(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: RefreshIndicator(
                          color: AppColors.mainColor,
                          onRefresh: () async {
                            ref.invalidate(recipeProviderProvider);
                          },
                          child: (ref.watch(recipeProviderProvider) == null)
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.mainColor,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: recipes.length,
                                  itemBuilder: (context, index) {
                                    return RecipeCard(recipe: recipes[index]);
                                  },
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget appBarRow(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recipe Hub',
                style: AppTextStyles.primaryTextStyle,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.primaryText,
                    ),
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.recipeSearchScreen);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu, color: AppColors.primaryText),
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.menuScreen);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: AppColors.mainColor,
          height: 0,
        ),
      ],
    );
  }

  Widget profilePostRow(BuildContext context, UserModel user) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.profileScreen);
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.mainColor.withOpacity(0.1),
                  radius: 20,
                  backgroundImage: (user.image.isEmpty)
                      ? null
                      : Image.network(user.image).image,
                  child: (user.image.isEmpty)
                      ? const Icon(
                          Icons.person,
                          color: AppColors.primaryText,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              const CreateRecipeContainer(),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.image, color: AppColors.primaryText),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Divider(
          color: AppColors.mainColor,
          height: 0,
        ),
      ],
    );
  }
}
