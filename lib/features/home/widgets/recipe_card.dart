import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/data/model/recipe_model.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/features/home/recipe_details.dart';
import 'package:recipe_app/features/home/widgets/user_action_button.dart';
import 'package:recipe_app/features/profile/widgets/edit_info_dialog.dart';
import 'package:recipe_app/features/shared_widgets/custum_alert_dialog.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';

class RecipeCard extends ConsumerStatefulWidget {
  const RecipeCard(
      {super.key,
      required this.recipe,
      this.signedUserListings,
      this.signeduserFavourites});
  final RecipeModel recipe;
  final bool? signedUserListings;
  final bool? signeduserFavourites;

  @override
  ConsumerState<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends ConsumerState<RecipeCard>
    with AutomaticKeepAliveClientMixin {
  late final Future<UserModel?> userdetails;

  @override
  void initState() {
    super.initState();
    userdetails =
        ref.read(recipeProviderProvider.notifier).getUser(widget.recipe.userID);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build to ensure keep-alive functionality
    return FutureBuilder<UserModel?>(
      future: userdetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading user details'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('User not found'));
        } else {
          final user = snapshot.data!;
          print(user.userID);
          return card(context, widget.recipe, user, ref,
              widget.signedUserListings, widget.signeduserFavourites);
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => false; // Ensure the state is kept alive
}

Widget card(BuildContext context, RecipeModel recipe, UserModel user,
    WidgetRef ref, bool? userListing, bool? signeduserFavourites) {
  // Safely calculate the rating or default to 0.0 if ratings are empty
  double roundToQuarter(double value) {
    return (value * 4).round() / 4; // Multiply by 4, round, and divide by 4
  }

  double rating = recipe.ratings.isNotEmpty
      ? recipe.ratings.reduce((a, b) => a + b) / recipe.ratings.length / 5
      : 0.0;

  return Card(
    color: AppColors.secondaryText,
    shadowColor: AppColors.mainColor.withOpacity(0.5),
    shape: const RoundedRectangleBorder(),
    elevation: 5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
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
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: AppTextStyles.secondaryTextStyle,
                  ),
                  Row(
                    children: [
                      (rating == 0)
                          ? const SizedBox()
                          : Text(
                              rating.toStringAsFixed(
                                  2), // Format rating to 2 decimals
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 12,
                              ),
                            ),
                      RatingBar.builder(
                        itemSize: 20,
                        initialRating:
                            roundToQuarter(rating), // Use the safe rating value
                        minRating: 0,
                        maxRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 1,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.fastfood_outlined,
                          color: AppColors.mainColor,
                        ),
                        ignoreGestures: true, // Makes it non-editable
                        onRatingUpdate: (rating) {}, // No action needed
                      ),
                      Text(
                        '(${recipe.ratings.length})',
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '. ${DateTime.now().difference(recipe.date).inHours} hours ago',
                        style: AppTextStyles.subTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              (userListing == null)
                  ? const SizedBox()
                  : PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert), // Three dots icon
                      onSelected: (String value) async {
                        if (value == 'edit') {
                          // Handle edit action
                          showDialog(
                            context: context,
                            builder: (context) => EditInfoDialog(
                              recipe: recipe,
                              isRecipe: true,
                            ),
                          );
                          print('Edit selected');
                        } else if (value == 'delete') {
                          ref
                              .read(recipeProviderProvider.notifier)
                              .deleteRecipe(
                                  ref.watch(userProviderProvider)!.userID,
                                  recipe.recipeID);
                          print('Delete selected');
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              const Icon(Icons.edit,
                                  color: AppColors.mainColor),
                              const SizedBox(width: 8),
                              const Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: AppColors.mainColor),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      recipe.title,
                      style: const TextStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetails(
                              user: user,
                              recipe: recipe,
                            ),
                          ));
                    },
                    child: Text(
                      '...See more',
                      style: AppTextStyles.secondaryTextStyle,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        (recipe.imageLink.isEmpty)
            ? const SizedBox()
            : Center(
                child: Image.network(
                  recipe.imageLink,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                ),
              ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserActionButton(
                  onSelected: () {
                    ref.read(recipeProviderProvider.notifier).updateRecipe(
                        signedUser: ref.watch(userProviderProvider)!.userID,
                        recipeID: recipe.recipeID,
                        userLikeID: ref.watch(userProviderProvider)!.userID);
                    if (signeduserFavourites == true) {
                      ref.invalidate(recipeProviderProvider);
                    }
                  },
                  onUnSelected: () {
                    ref.read(recipeProviderProvider.notifier).updateRecipe(
                        signedUser: ref.watch(userProviderProvider)!.userID,
                        recipeID: recipe.recipeID,
                        userDisLikeID: ref.watch(userProviderProvider)!.userID);
                    if (signeduserFavourites == true) {
                      ref.invalidate(recipeProviderProvider);
                    }
                  },
                  isSelected: recipe.likes
                      .contains(ref.watch(userProviderProvider)!.userID),
                  icon: Icons.thumb_up_alt_outlined,
                  filledIcon: Icons.thumb_up_alt,
                  text: recipe.likes.length.toString()),
              const SizedBox(height: 10, child: VerticalDivider()),
              // UserActionButton(
              //     onSelected: () {},
              //     onUnSelected: () {},
              //     isSelected: recipe.likes.contains(user.userID),
              //     icon: Icons.comment,
              //     filledIcon: Icons.comment,
              //     text: '3'),
              // const SizedBox(height: 10, child: VerticalDivider()),
              UserActionButton(
                  onSelected: () async {
                    ref.read(recipeProviderProvider.notifier).updateRecipe(
                        recipeID: recipe.recipeID,
                        signedUser: ref.watch(userProviderProvider)!.userID,
                        favouriteRecipeID: recipe.recipeID);
                    if (signeduserFavourites == true) {
                      ref.invalidate(recipeProviderProvider);
                    }
                  },
                  onUnSelected: () {
                    ref.read(recipeProviderProvider.notifier).updateRecipe(
                        recipeID: recipe.recipeID,
                        signedUser: ref.watch(userProviderProvider)!.userID,
                        unfavouriteRecipeID: recipe.recipeID);
                    if (signeduserFavourites == true) {
                      ref.invalidate(recipeProviderProvider);
                    }
                  },
                  isSelected: ref
                      .watch(userProviderProvider)!
                      .favourites
                      .toList()
                      .contains(recipe.recipeID),
                  icon: Icons.favorite_border_outlined,
                  filledIcon: Icons.favorite,
                  text: ''),
            ],
          ),
        ),
      ],
    ),
  );
}
