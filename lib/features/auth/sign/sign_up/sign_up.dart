import 'package:flutter_riverpod/flutter_riverpod.dart';
//signup
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/app_router.dart';
import 'package:recipe_app/features/auth/sign/sign_up/widgets/google_facebook_sign.dart';
import 'package:recipe_app/features/auth/sign/sign_up/widgets/styled_text_navigation_to_from_signin.dart';
import 'package:recipe_app/features/auth/sign/sign_up/widgets/terms.dart';
import 'package:recipe_app/features/auth/sign/sign_up/widgets/text_between_divider.dart';
import 'package:recipe_app/features/auth/sign/sign_up/widgets/welcome_text.dart';
import 'package:recipe_app/features/shared_widgets/styled_button.dart';
import 'package:recipe_app/features/shared_widgets/styled_textField.dart';
import 'package:recipe_app/providers/user_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  //Key for validation
  final _formKey = GlobalKey<FormState>();

  // Create controllers for the TextFields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isloading = false;

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
    final userAuth = ref.read(userProviderProvider.notifier);

    return Container(
      color: AppColors.secondaryText,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.secondaryText,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //First three Rows of Text presentation of the title headline and text
                    const WelcomeText(
                        title: "Recipe Hub",
                        headline: "Registration 👍",
                        text: "Let’s Register. Explore Recipes!"),
                    const SizedBox(height: 30),
                    //TextFileds for name email password and confirm pass
                    StyledTextField(
                        hint: "Username",
                        icon: Icons.person_outlined,
                        controller: _fullNameController),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    StyledTextField(
                      hint: "Confirm Password",
                      icon: Icons.lock_outlined,
                      isPassword: true,
                      controller: _confirmPasswordController,
                      password: _passwordController,
                    ),

                    const SizedBox(height: 15),

                    (_isloading)
                        ? const Center(
                            child: LinearProgressIndicator(
                            color: AppColors.mainColor,
                          ))
                        :

                        //cubit
                        AbsorbPointer(
                            absorbing: _isloading,
                            child: StyledButton(
                                onPressed: () async {
                                  if (registerCheck()) {
                                    setState(() {
                                      _isloading = true;
                                    });
                                    bool result = await userAuth.signUp(
                                        _emailController.text,
                                        _passwordController.text,
                                        _fullNameController.text);

                                    if (result) {
                                      _isloading = false;
                                      GoRouter.of(context).pushReplacement(
                                          AppRouter.homeScreen);
                                    } else if (!result) {
                                      setState(() {
                                        _isloading = false;
                                      });
                                    }
                                  }
                                },
                                text: "Register"),
                          ),

                    const SizedBox(height: 15),
                    const Terms(),
                    const SizedBox(height: 15),

                    //Text between two lines
                    const TextBetweenDivider(text: "Or continue with"),
                    const SizedBox(height: 30),

                    //Row for the Google and facebook Login
                    const GoogleFacebookSign(),
                    const SizedBox(height: 50),

                    //Row with Text and TextButton for navigation to Login screen
                    const StyledTextNavigationToFromSignin(
                        headText: "Haven an account?", tailText: 'Log in'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
