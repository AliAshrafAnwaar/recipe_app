import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/data/model/recipe_model.dart';
import 'package:recipe_app/features/shared_widgets/styled_button.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';

class RateRecipeDialog extends ConsumerStatefulWidget {
  final RecipeModel recipe;

  const RateRecipeDialog({required this.recipe, Key? key}) : super(key: key);

  @override
  _RateRecipeDialogState createState() => _RateRecipeDialogState();
}

class _RateRecipeDialogState extends ConsumerState<RateRecipeDialog> {
  late double currentRating;
  late double averageRating;

  @override
  void initState() {
    super.initState();
    averageRating = widget.recipe.ratings.isNotEmpty
        ? widget.recipe.ratings.reduce((a, b) => a + b) /
            widget.recipe.ratings.length
        : 3.0; // Default average rating is 3.0 if no ratings exist.
    currentRating = averageRating;
  }

  Future<void> _saveRating() async {
    if (currentRating > 0) {
      // Save the updated ratings using your provider or repository
      final recipeNotifier = ref.read(recipeProviderProvider.notifier);
      await recipeNotifier.updateRecipe(
        signedUser: ref.watch(userProviderProvider)!.userID,
        recipeID: widget.recipe.recipeID,
        rating: currentRating,
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Rating cannot be zero")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Rate Recipe",
              style: AppTextStyles.primaryTextStyle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
            RatingBar.builder(
              glow: false,
              itemSize: 32,
              initialRating: currentRating,
              minRating: 0.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.fastfood_outlined,
                color: AppColors.mainColor,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  currentRating = rating;
                });
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: StyledButton(
                onPressed: _saveRating,
                text: 'Save Rating',
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
