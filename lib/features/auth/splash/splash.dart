import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/app_router.dart';

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
        GoRouter.of(context).pushReplacementNamed(AppRouter.signUp);
      } else {
        if (mounted) {
          GoRouter.of(context).pushReplacementNamed(AppRouter.signUp);
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
          child: Center(
            child:
                // Icon(Icons.emoji_food_beverage, size: 100, color: Colors.white),
                Image.network(
              'https://firebasestorage.googleapis.com/v0/b/fire-auth-1cb50.appspot.com/o/job_image_8.jpg?alt=media&token=683efa44-2cc6-4011-9974-07e17ebcd64f',
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50.0,
                );
              },
            ),
          ),
        )));
  }
}
