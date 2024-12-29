import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/features/auth/sign/forget_password.dart/forget_password.dart';
import 'package:recipe_app/features/auth/sign/sign_in/sign_in.dart';
import 'package:recipe_app/features/auth/sign/sign_up/sign_up.dart';
import 'package:recipe_app/features/auth/splash/splash.dart';
import 'package:recipe_app/features/home/home.dart';
import 'package:recipe_app/features/home/menu.dart';
import 'package:recipe_app/features/profile/favourites.dart';
import 'package:recipe_app/features/profile/profile_screen.dart';
import 'package:recipe_app/features/create_recipe/create_recipe.dart';
import 'package:recipe_app/features/profile/user_listings.dart';
import 'package:recipe_app/features/search/search.dart';

class AppRouter {
  static const splash = "/splash";
  static const signUp = "/signUp";
  static const signIn = "/signIn";
  static const forgetPassword = "/forgetPassword";
  static const homeScreen = "/home";
  static const menuScreen = "/menu";
  static const recipeDetails = "/recipeDetails";
  static const recipeCreate = "/recipeCreate";
  static const profileScreen = "/profileScreen";
  static const recipeSearchScreen = "/recipeSearchScreen";
  static const favouriteList = "/favouriteList";
  static const userListings = "/userListings";

  static GoRouter router = GoRouter(
    initialLocation: splash,
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: splash,
        name: splash,
        builder: (context, state) => const Splash(),
      ),
      GoRoute(
        path: signUp,
        name: signUp,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignUpScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: signIn,
        name: signIn,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignInScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: forgetPassword,
        name: forgetPassword,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ForgetPasswordScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: homeScreen,
        name: homeScreen,
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: recipeSearchScreen,
        name: recipeSearchScreen,
        builder: (context, state) => const Search(),
      ),
      GoRoute(
        path: favouriteList,
        name: favouriteList,
        builder: (context, state) => const Favourites(),
      ),
      GoRoute(
        path: userListings,
        name: userListings,
        builder: (context, state) => const UserListings(),
      ),
      GoRoute(
        path: recipeCreate,
        name: recipeCreate,
        builder: (context, state) => const CreateRecipe(),
      ),
      GoRoute(
        path: profileScreen,
        name: profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: menuScreen,
        name: menuScreen,
        builder: (context, state) => const Menu(),
      ),
    ],
  );

  // Slide transition
  static Widget _slideTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1.0, 0.0); // Slide from right
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  // Fade transition
  static Widget _fadeTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
