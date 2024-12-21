// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/features/shared_widgets/styled_button.dart';

class EditInfoDialog extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();

  bool isNameValid() {
    if (nameController.text.contains(' ') &&
        nameController.text[0] == nameController.text[0].toUpperCase() &&
        nameController.text[nameController.text.indexOf(' ') + 1] ==
            nameController.text[nameController.text.indexOf(' ') + 1]
                .toUpperCase()) {
      return true;
    }
    return false;
  }

  bool isPhoneNumberValid() {
    if (phoneNumberController.text.length == 11 &&
        phoneNumberController.text[0] == '0' &&
        phoneNumberController.text[1] == '1') {
      return true;
    }
    return false;
  }

  bool isJopTitleValid() {
    if (jobTitleController.text[0] ==
        jobTitleController.text[0].toUpperCase()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EditInfoTextFiled(
              initialText: 'name',
              controller: nameController,
              hint: "Full Name",
              icon: Icons.person,
            ),
            EditInfoTextFiled(
              initialText: 'user!.phoneNumber' ?? '',
              controller: phoneNumberController,
              hint: 'Phone Number',
              icon: Icons.phone,
            ),
            EditInfoTextFiled(
              initialText: 'user!.profile!.jobTitle' ?? '',
              controller: jobTitleController,
              hint: "Job Title",
              icon: Icons.title,
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: StyledButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty ||
                      phoneNumberController.text.isNotEmpty ||
                      jobTitleController.text.isNotEmpty) {
                    if (isNameValid()) {
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Name is not valid"),
                        ),
                      );
                    }
                    if (isPhoneNumberValid()) {
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Phone number is not valid"),
                        ),
                      );
                    }
                    if (isJopTitleValid()) {
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("job Title is not valid"),
                        ),
                      );
                    }

                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Fields can't be empty"),
                      ),
                    );
                  }
                },
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

class EditInfoTextFiled extends StatelessWidget {
  final String initialText;
  final IconData icon;
  final TextEditingController controller;
  final String hint;

  const EditInfoTextFiled({
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
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
