import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/app_router.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  @override
  void initState() {
    super.initState();
    navigateFromSplash();
  }

  void navigateFromSplash() async {
    // Wait for 3 seconds for the splash screen effect
    await Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userToken = prefs.getString('userToken'); // Retrieve the token

      // Check if userToken is not null and navigate accordingly
      if (userToken != null && userToken.isNotEmpty) {
        // If token exists, user is already logged in
        if (mounted) {
          await ref
              .read(userProviderProvider.notifier)
              .sharedPreferenceLogin(userToken);
          GoRouter.of(context).pushReplacementNamed(
              AppRouter.homeScreen); // Navigate to the home page
        }
      } else {
        // If token is null or empty, user needs to log in
        if (mounted) {
          GoRouter.of(context).pushReplacementNamed(
              AppRouter.signUp); // Navigate to the sign-up page
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
            child: Container(
          color: AppColors.primaryColor,
          padding: const EdgeInsets.all(100),
          child: const Center(
            child:
                Icon(Icons.emoji_food_beverage, size: 100, color: Colors.white),
          ),
        )));
  }
}
