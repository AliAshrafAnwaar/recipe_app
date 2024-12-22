import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/features/shared_widgets/styled_button.dart';
import 'package:recipe_app/features/shared_widgets/styled_textField.dart';

class CreateRecipe extends StatelessWidget {
  const CreateRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryText,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryText,
        centerTitle: true,
        title: Text(
          'Create Recipe',
          style: AppTextStyles.primaryTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const StyledTextField(hint: 'Title', icon: Icons.title),
                  const SizedBox(height: 10),
                  const StyledTextField(
                    hint: 'Description',
                    icon: Icons.description,
                    maxLines: 10,
                  ),
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
                          SizedBox(
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
      ),
    );
  }
}
