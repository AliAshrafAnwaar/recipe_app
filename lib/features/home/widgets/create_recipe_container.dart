import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';

class CreateRecipeContainer extends StatelessWidget {
  const CreateRecipeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.mainColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text('Recipe in mind?'),
      ),
    );
  }
}
