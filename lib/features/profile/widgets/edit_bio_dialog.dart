import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/features/shared_widgets/styled_button.dart';
import 'package:recipe_app/features/shared_widgets/styled_textField.dart';
import 'package:recipe_app/providers/user_provider.dart';

class EditBioDialog extends ConsumerWidget {
  final TextEditingController bioController = TextEditingController();
  EditBioDialog({super.key, required this.user});

  final UserModel user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifier = ref.read(userProviderProvider.notifier);
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
            SizedBox(
              width: double.infinity,
              child: StyledButton(
                text: "Save Changes",
                onPressed: () async {
                  await userNotifier.updateUserDetails(
                      user: user, newBio: bioController.text);

                  print("done");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
