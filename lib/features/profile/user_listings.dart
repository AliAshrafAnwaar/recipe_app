import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/data/model/recipe_model.dart';
import 'package:recipe_app/features/home/widgets/recipe_card.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

class UserListings extends ConsumerStatefulWidget {
  const UserListings({super.key});

  @override
  ConsumerState<UserListings> createState() => _UserListingsState();
}

class _UserListingsState extends ConsumerState<UserListings> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProviderProvider);
    List<String> recipeIDs =
        (user != null && user.recipes.isNotEmpty) ? user.recipes.toList() : [];
    return Scaffold(
      backgroundColor: AppColors.secondaryText,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryText,
        title: Text(
          'My Listings',
          style: AppTextStyles.primaryTextStyle,
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.mainColor,
        onRefresh: () async {
          await ref
              .read(userProviderProvider.notifier)
              .sharedPreferenceLogin(user!.userID);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(
              color: AppColors.mainColor,
              thickness: 1,
            ),
            (recipeIDs.isEmpty)
                ? const Expanded(
                    child: Center(
                      child: Text('No Recipes'),
                    ),
                  )
                : Expanded(
                    child: FutureBuilder<Set<RecipeModel>>(
                      future: ref
                          .read(userProviderProvider.notifier)
                          .getCollection(recipeIDs: recipeIDs),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No Recipes'),
                          );
                        } else {
                          final recipes = snapshot.data!.toList();
                          return ListView.builder(
                            itemCount: recipes.length,
                            itemBuilder: (context, index) {
                              return RecipeCard(
                                recipe: recipes[index],
                                signedUserListings: true,
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
