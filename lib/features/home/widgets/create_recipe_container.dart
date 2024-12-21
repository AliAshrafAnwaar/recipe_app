import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/app_router.dart';

class CreateRecipeContainer extends StatelessWidget {
  const CreateRecipeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () {
          GoRouter.of(context).push(AppRouter.recipeCreate);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.mainColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text('Recipe in mind?'),
        ),
      ),
    );
  }
}
