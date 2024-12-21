import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/features/auth/splash/splash.dart';
import 'package:recipe_app/features/home/home.dart';
import 'package:recipe_app/features/home/menu.dart';

class AppRouter {
  static const splash = "/splash";
  static const onBoardingScreens = "/onBoardingScreens";
  static const signUp = "/signUp";
  static const login = "/login";
  static const forgetPassword = "/forgetPassword";
  static const homeScreen = "/home";
  static const jobApplyScreen = "/jobApplyScreen";
  static const jobPostScreen = "/jobPostScreen";
  static const profileScreen = "/profileScreen";
  static const resumeUploadScreen = "/resumeUploadScreen";
  static const menuScreen = "/settingsScreen";
  static const applicationsScreen = "/applicationsScreen";
  static const allApplicantsScreen = "/allApplicantsScreen";
  static const myPostedJob = "/myPostedJob";
  static const successScreen = "/successScreen";
  static const jobSearchScreen = "/jobSearchScreen";
  static const seeAllPage = "/seeAllPage";
  static const pageViewModel = "/pageViewModel";
  static const recentSearches = "/recentSearches";
  static const jobList = "/jobList";
  static const userList = "/userList";
  static const othersProfileScreen = "/othersProfileScreen";

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
      // GoRoute(
      //   name: onBoardingScreens,
      //   path: onBoardingScreens,
      //   builder: (context, state) => const OnBoardingScreen1(),
      // ),
      // GoRoute(
      //   path: signUp,
      //   name: signUp,
      //   pageBuilder: (context, state) => CustomTransitionPage(
      //     key: state.pageKey,
      //     child: const SignUpScreen(),
      //     transitionsBuilder: _fadeTransition, // Slide transition
      //   ),
      // ),
      // GoRoute(
      //   path: login,
      //   name: login,
      //   pageBuilder: (context, state) => CustomTransitionPage(
      //     key: state.pageKey,
      //     child: const LoginScreen(),
      //     transitionsBuilder: _fadeTransition,
      //   ),
      // ),
      // GoRoute(
      //   path: forgetPassword,
      //   name: forgetPassword,
      //   pageBuilder: (context, state) => CustomTransitionPage(
      //     key: state.pageKey,
      //     child: const ForgetPasswordScreen(),
      //     transitionsBuilder: _slideTransition, // Slide transition
      //   ),
      // ),
      GoRoute(
        path: homeScreen,
        name: homeScreen,
        builder: (context, state) => const Home(),
      ),
      // GoRoute(
      //   path: jobSearchScreen,
      //   name: jobSearchScreen,
      //   builder: (context, state) => const JobSearchScreen(),
      // ),
      // GoRoute(
      //   path: jobList,
      //   name: jobList,
      //   builder: (context, state) {
      //     final Map<String, dynamic> extra =
      //         state.extra as Map<String, dynamic>;
      //     return JobListScreen(
      //       jobTitle: extra['jobTitle'] as String,
      //       jobs: extra['jobs'] as List<PostedJob>,
      //     );
      //   },
      // ),
      // GoRoute(
      //     path: userList,
      //     name: userList,
      //     builder: (context, state) {
      //       final Map<String, dynamic> extra =
      //           state.extra as Map<String, dynamic>;
      //       return UserListScreen(
      //         userName: extra['userName'] as String,
      //         users: extra['users'] as List<UserModel>,
      //       );
      //     }),
      // GoRoute(
      //   path: recentSearches,
      //   name: recentSearches,
      //   builder: (context, state) => const RecentSearchesScreen(),
      // ),
      // GoRoute(
      //   path: othersProfileScreen,
      //   name: othersProfileScreen,
      //   builder: (context, state) {
      //     final Map<String, dynamic> extra =
      //         state.extra as Map<String, dynamic>;
      //     return OthersProfileScreen(
      //       user: extra['user']as List<UserModel>,
      //       index: extra['index'] as int,
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: jobApplyScreen,
      //   name: jobApplyScreen,
      //   builder: (context, state) =>
      //       JobApplyScreen(job: state.extra as PostedJob),
      // ),

      // GoRoute(
      //   path: successScreen,
      //   name: successScreen,
      //   builder: (context, state) => SuccefullScreen(),
      // ),
      // GoRoute(
      //   path: jobPostScreen,
      //   name: jobPostScreen,
      //   builder: (context, state) => JobPostScreen(),
      // ),
      // GoRoute(
      //   path: seeAllPage,
      //   name: seeAllPage,
      //   builder: (context, state) => SeeAllPage(),
      // ),

      // GoRoute(
      //   path: myPostedJob,
      //   name: myPostedJob,
      //   builder: (context, state) => const MyPostedJob(),
      // ),
      // GoRoute(
      //     path: pageViewModel,
      //     name: pageViewModel,
      //     builder: (context, state) => const PageViewModel()),
      // GoRoute(
      //   path: allApplicantsScreen,
      //   name: allApplicantsScreen,
      //   builder: (context, state) =>
      //       AllApplicantsScreen(jobId: state.extra as String),
      // ),
      // //bodaSayed
      // GoRoute(
      //   path: profileScreen,
      //   name: profileScreen,
      //   builder: (context, state) => BlocProvider.value(
      //     value: profileCubit,
      //     child: ProfileScreen(),
      //   ),
      // ),
      // GoRoute(
      //     path: resumeUploadScreen,
      //     name: resumeUploadScreen,
      //     builder: (context, state) => BlocProvider.value(
      //           value: profileCubit,
      //           child: ResumeUploadScreen(),
      //         )),
      GoRoute(
          path: menuScreen,
          name: menuScreen,
          builder: (context, state) => const Menu()),
      // GoRoute(
      //   path: applicationsScreen,
      //   name: applicationsScreen,
      //   builder: (context, state) => BlocProvider.value(
      //     value: profileCubit,
      //     child: ApplicationsScreen(),
      //   ),
      // ),
      // //end bodaSayed
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
