import 'package:flutter/material.dart';
import 'package:recipe_app/core/utils/app_router.dart';

void main() async {
  runApp(
    const JopFinderApp(),
  );
}

class JopFinderApp extends StatelessWidget {
  const JopFinderApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
