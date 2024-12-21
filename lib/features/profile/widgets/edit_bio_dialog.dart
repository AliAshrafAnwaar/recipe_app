import 'package:flutter/material.dart';
import 'package:recipe_app/features/shared_widgets/styled_button.dart';
import 'package:recipe_app/features/shared_widgets/styled_textField.dart';

class EditBioDialog extends StatelessWidget {
  final TextEditingController bioController = TextEditingController();
  EditBioDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StyledTextField(
              icon: Icons.info,
              controller: bioController,
              hint: "Enter your new bio",
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: StyledButton(
                text: "Save Changes",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
