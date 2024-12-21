import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/features/shared_widgets/styled_button.dart';
import 'package:recipe_app/features/shared_widgets/styled_textField.dart';

class RecipeCreate extends StatelessWidget {
  const RecipeCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Recipe',
          style: AppTextStyles.primaryTextStyle,
        ),
      ),
      body: Column(
        children: [
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StyledTextField(hint: 'Titile', icon: Icons.title),
                const SizedBox(height: 10),
                StyledTextField(hint: 'Description', icon: Icons.description),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.image,
                          color: AppColors.primaryText,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('photo')
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                StyledButton(onPressed: () {}, text: 'Create Recipe')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
