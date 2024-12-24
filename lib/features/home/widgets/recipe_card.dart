import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/app_router.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/data/model/recipe_model.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/features/home/recipe_details.dart';
import 'package:recipe_app/features/home/widgets/user_action_button.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';

class RecipeCard extends ConsumerStatefulWidget {
  const RecipeCard({super.key, required this.recipe});
  final RecipeModel recipe;

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
          return SizedBox();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading user details'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('User not found'));
        } else {
          final user = snapshot.data!;
          return card(context, widget.recipe, user);
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true; // Ensure the state is kept alive
}

Widget card(BuildContext context, RecipeModel recipe, UserModel user) {
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
            children: [
              CircleAvatar(backgroundImage: Image.network(user.image).image),
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    recipe.title,
                    style: TextStyle(),
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
            ? SizedBox()
            : Center(child: Image.network(recipe.imageLink)),
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserActionButton(icon: Icons.thumb_up_alt_outlined, text: '1'),
              UserActionButton(icon: Icons.comment, text: '3'),
              UserActionButton(icon: Icons.favorite_border_outlined, text: ''),
            ],
          ),
        ),
      ],
    ),
  );
}
