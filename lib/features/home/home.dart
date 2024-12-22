import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/app_router.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/features/home/widgets/create_recipe_container.dart';
import 'package:recipe_app/features/home/widgets/recipe_card.dart';
import 'package:recipe_app/providers/user_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? user = ref.watch(userProviderProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.secondaryText,
          body: SingleChildScrollView(
            child: Column(
              children: [
                appBarRow(context),
                profilePostRow(context, user!),
                RecipeCard(),
                RecipeCard(),
                RecipeCard(),
                RecipeCard(),
              ],
            ),
          ),
        ),
      ),
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
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu, color: AppColors.primaryText),
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.menuScreen);
                      ;
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
                  backgroundColor: AppColors.primaryColor.withOpacity(0.5),
                  radius: 20,
                  backgroundImage: Image.network(user.image).image,
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
