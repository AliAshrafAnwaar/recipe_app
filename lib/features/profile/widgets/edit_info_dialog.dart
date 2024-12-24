import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';
import 'package:recipe_app/data/model/user_model.dart';
import 'package:recipe_app/features/shared_widgets/styled_button.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:recipe_app/data/repo/main_repo.dart';

class EditInfoDialog extends ConsumerStatefulWidget {
  final UserModel user;

  const EditInfoDialog({required this.user});

  @override
  _EditInfoDialogState createState() => _EditInfoDialogState();
}

class _EditInfoDialogState extends ConsumerState<EditInfoDialog> {
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.username);
    phoneNumberController =
        TextEditingController(text: widget.user.phoneNumber);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  bool isNameValid() {
    final name = nameController.text.trim();
    final nameRegex = RegExp(r'^[a-zA-Z\W]*$');

    if (name.contains(' ')) {
      return false;
    }

    return nameRegex.hasMatch(name);
  }

  bool isPhoneNumberValid() {
    if (phoneNumberController.text.length == 11 &&
        phoneNumberController.text[0] == '0' &&
        phoneNumberController.text[1] == '1') {
      return true;
    }
    return false;
  }

  Future<void> _saveChanges() async {
    if (nameController.text.isNotEmpty ||
        phoneNumberController.text.isNotEmpty) {
      if (!isNameValid()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Name is not valid"),
          ),
        );
        return;
      }
      if (!isPhoneNumberValid()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Phone number is not valid"),
          ),
        );
        return;
      }

      UserModel updatedUser = widget.user.copyWith(
        username: nameController.text,
        phoneNumber: phoneNumberController.text,
      );

      final user = ref.read(userProviderProvider.notifier);
      await user.updateUserDetails(
          user: updatedUser,
          newUsername: nameController.text,
          newPhoneNumber: phoneNumberController.text);

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Fields can't be empty"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EditInfoTextField(
              initialText: widget.user.username,
              controller: nameController,
              hint: "Username",
              icon: Icons.person,
            ),
            EditInfoTextField(
              initialText: widget.user.phoneNumber.isEmpty
                  ? ''
                  : widget.user.phoneNumber,
              controller: phoneNumberController,
              hint: 'Phone Number',
              icon: Icons.phone,
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: StyledButton(
                onPressed: _saveChanges,
                text: 'Save Changes',
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class EditInfoTextField extends StatelessWidget {
  final String initialText;
  final IconData icon;
  final TextEditingController controller;
  final String hint;

  const EditInfoTextField({
    super.key,
    required this.initialText,
    required this.icon,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with the user's name
    controller.text = initialText;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 13, 13, 38),
              fontSize: 14,
              fontWeight: FontWeight.w400),
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 175, 176, 182), fontSize: 14),
          prefixIcon: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 175, 176, 182), width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(102, 175, 176, 182),
            ),
          ),
          focusColor: const Color.fromARGB(255, 13, 13, 38),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 13, 13, 38), width: 1),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
        controller: controller, // Use the passed controller
        maxLines: 1,
        style: AppTextStyles.secondaryTextStyle,
      ),
    );
  }
}
