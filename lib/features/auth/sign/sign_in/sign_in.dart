//signup
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/app_router.dart';
import 'package:recipe_app/data/repo/main_repo.dart';
import 'package:recipe_app/features/auth/sign/sign_up/widgets/google_facebook_sign.dart';
import 'package:recipe_app/features/auth/sign/sign_up/widgets/styled_text_navigation_to_from_signin.dart';
import 'package:recipe_app/features/auth/sign/sign_up/widgets/text_between_divider.dart';
import 'package:recipe_app/features/auth/sign/sign_up/widgets/welcome_text.dart';
import 'package:recipe_app/features/shared_widgets/styled_button.dart';
import 'package:recipe_app/features/shared_widgets/styled_textField.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //Key for validation
  final _formKey = GlobalKey<FormState>();
  final _repo = MainRepo();

  // Create controllers for the TextFields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Register button onpressed
  bool registerCheck() {
    //condition to check the validation of textfields
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondaryText,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //First three Rows of Text presentation of the title headline and text
                  const WelcomeText(
                      title: "Jôbizz",
                      headline: "Welcome Back 👋",
                      text: "Let’s log in. Apply to jobs!"),
                  const SizedBox(height: 50),

                  //TextFileds for name email password and confirm pass
                  StyledTextField(
                      hint: "E-mail",
                      icon: Icons.mail_outline_outlined,
                      controller: _emailController),
                  const SizedBox(height: 16),
                  StyledTextField(
                      hint: "Password",
                      icon: Icons.lock_outlined,
                      isPassword: true,
                      controller: _passwordController),

                  const SizedBox(height: 15),

                  // cubit builder
                  StyledButton(
                      onPressed: () async {
                        if (registerCheck()) {
                          await _repo.signIn(
                              _emailController.text, _passwordController.text);

                          GoRouter.of(context).push(AppRouter.homeScreen);
                        }
                      },
                      text: "Log in"),

                  const SizedBox(height: 30),

                  //Forgetpassword Text button
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed(AppRouter.forgetPassword);
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //Text between two lines
                  const TextBetweenDivider(text: "Or continue with"),
                  const SizedBox(height: 30),

                  //Row for the Google and facebook Login
                  const GoogleFacebookSign(),
                  const SizedBox(height: 30),

                  // Row for Navigating to Sign in Screen contains text and texButton
                  const StyledTextNavigationToFromSignin(
                      headText: "Haven't an account?", tailText: 'Register'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
