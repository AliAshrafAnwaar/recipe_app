//forgetpassword

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/features/auth/sign/sign_up/widgets/welcome_text.dart';
import 'package:recipe_app/features/shared_widgets/styled_button.dart';
import 'package:recipe_app/features/shared_widgets/styled_textField.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool validation() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _resetController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _resetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryText,
      ),
      backgroundColor: AppColors.secondaryText,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const WelcomeText(
                    title: "Recipe Hub",
                    headline: "Forgot Password",
                    text:
                        "Enter your email or phone number, we will send you verification code",
                    crossAxisAlignment: "center",
                    innerPadding: 30,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 242, 246, 253),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: FilledButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.myWhite)),
                        onPressed: () {},
                        child: const Text(
                          "E-mail",
                          style: TextStyle(
                              fontSize: 13, color: AppColors.primaryText),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  StyledTextField(
                      hint: "E-mail",
                      icon: Icons.mail_outline_outlined,
                      controller: _resetController),
                  Column(
                    children: [
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: StyledButton(
                              onPressed: () {
                                if (validation()) {}
                              },
                              text: "Send Code",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
