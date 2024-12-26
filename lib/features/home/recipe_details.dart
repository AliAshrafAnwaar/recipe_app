import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/data/model/recipe_model.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/features/home/widgets/rate_recipe_dialog.dart';
import 'package:recipe_app/features/home/widgets/user_action_button.dart';
import 'package:recipe_app/features/profile/widgets/edit_info_dialog.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

class RecipeDetails extends ConsumerWidget {
  const RecipeDetails({super.key, required this.user, required this.recipe});

  final UserModel user;
  final RecipeModel recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: AppColors.secondaryText,
        appBar: AppBar(
          backgroundColor: AppColors.secondaryText,
          title: Text(
            "${user.username}'s Recipe",
            style: AppTextStyles.secondaryTextStyle,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => RateRecipeDialog(recipe: recipe),
                );
              },
              icon: const Icon(
                Icons.fastfood_outlined,
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const Divider(
                  color: AppColors.mainColor,
                  thickness: 1,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  AppColors.mainColor.withOpacity(0.1),
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
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.username,
                                  style: AppTextStyles.secondaryTextStyle,
                                ),
                                Text(
                                  '${DateTime.now().difference(recipe.date).inHours} hours ago',
                                  style: AppTextStyles.subTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              recipe.title,
                              style: AppTextStyles.secondaryTextStyle,
                            ),
                            Text(
                              recipe.description.trim(),
                            ),
                          ],
                        ),
                      ),
                      (recipe.imageLink.isEmpty)
                          ? SizedBox()
                          : Image.network(
                              recipe.imageLink,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UserActionButton(
                              onSelected: () {
                                ref
                                    .read(recipeProviderProvider.notifier)
                                    .updateRecipe(
                                        recipeID: recipe.recipeID,
                                        userLikeID: user.userID);
                              },
                              onUnSelected: () {
                                ref
                                    .read(recipeProviderProvider.notifier)
                                    .updateRecipe(
                                        recipeID: recipe.recipeID,
                                        userDisLikeID: user.userID);
                              },
                              isSelected: recipe.likes.contains(user.userID),
                              icon: Icons.thumb_up_alt_outlined,
                              filledIcon: Icons.thumb_up_alt,
                              text: recipe.likes.length.toString()),
                          const SizedBox(height: 10, child: VerticalDivider()),
                          UserActionButton(
                              onSelected: () {},
                              onUnSelected: () {},
                              isSelected: recipe.likes.contains(user.userID),
                              icon: Icons.comment,
                              filledIcon: Icons.comment,
                              text: '3'),
                          const SizedBox(height: 10, child: VerticalDivider()),
                          UserActionButton(
                              onSelected: () {},
                              onUnSelected: () {},
                              isSelected: recipe.likes.contains(user.userID),
                              icon: Icons.favorite_border_outlined,
                              filledIcon: Icons.favorite,
                              text: ''),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
