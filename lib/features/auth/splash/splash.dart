import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    navigateFromSplash();
    super.initState();
  }

  void navigateFromSplash() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      String? userToken;
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      if (userToken != null) {
        GoRouter.of(context).pushReplacementNamed(AppRouter.homeScreen);
      } else {
        if (mounted) {
          GoRouter.of(context).pushReplacementNamed(AppRouter.homeScreen);
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
