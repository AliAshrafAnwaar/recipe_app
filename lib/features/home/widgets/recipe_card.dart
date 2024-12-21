import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/features/home/widgets/user_action_button.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      child: Card(
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
                  CircleAvatar(
                      backgroundImage:
                          Image.asset('assets/images/profile.jpg').image),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recipe Author',
                        style: AppTextStyles.secondaryTextStyle,
                      ),
                      Text(
                        'Date',
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
                        'Recipe Name',
                        style: AppTextStyles.secondaryTextStyle,
                      ),
                      TextButton(onPressed: () {}, child: Text('...See more'))
                    ],
                  ),
                ],
              ),
            ),
            Image.asset('assets/images/profile.jpg'),
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserActionButton(
                      icon: Icons.thumb_up_alt_outlined, text: '1'),
                  UserActionButton(icon: Icons.comment, text: '3'),
                  UserActionButton(
                      icon: Icons.favorite_border_outlined, text: ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
