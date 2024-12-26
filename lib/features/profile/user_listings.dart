import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/data/model/recipe_model.dart';
import 'package:recipe_app/features/home/widgets/recipe_card.dart';
import 'package:recipe_app/providers/user_provider.dart';

class UserListings extends ConsumerStatefulWidget {
  const UserListings({super.key});

  @override
  ConsumerState<UserListings> createState() => _UserListingsState();
}

class _UserListingsState extends ConsumerState<UserListings> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProviderProvider);
    List<RecipeModel> recipes =
        (user != null && user.recipes.isNotEmpty) ? user.recipes.toList() : [];
    return Scaffold(
      backgroundColor: AppColors.secondaryText,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryText,
        title: Text(
          'Recipes',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(
              color: AppColors.mainColor,
              thickness: 1,
            ),
            (user!.recipes.isEmpty)
                ? const Expanded(
                    child: Center(
                      child: Text('No Recipes'),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          return RecipeCard(
                            recipe: recipes[index],
                            userListings: true,
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
