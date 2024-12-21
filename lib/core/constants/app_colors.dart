import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF562114); // Deep, rich brown
  static const Color mainColor =
      Color(0xFF8E270E); // Dark red with earthy tones
  static const Color primaryText = Color(0xFFB7410E); // Bold burnt orange
  static const Color secondaryText = Color(0xFFF0E1D1); // Light beige
  static const Color subText = Color(0xFFBCBAAE); // Muted grayish-green
  static const Color hintColor =
      Color.fromARGB(255, 175, 176, 182); // Keeping original
  static const Color myWhite =
      Color.fromARGB(255, 250, 250, 253); // Keeping original
  static const Color myWhiteBackground =
      Color.fromARGB(255, 250, 250, 253); // Keeping original
  static const Color myRed = Color.fromARGB(255, 227, 0, 0); // Keeping original
}

ThemeData appTheme = ThemeData(
  //button theme
  colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor, primary: AppColors.primaryColor),

  //Scaffold Color
  scaffoldBackgroundColor: AppColors.myWhite,

  //appbar theme
  appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.mainColor,
      foregroundColor: AppColors.myWhite,
      surfaceTintColor: Colors.transparent,
      centerTitle: true),

  //Text theme
  textTheme: const TextTheme(
    //hint style
    bodySmall: TextStyle(
      color: AppColors.hintColor,
      fontSize: 14,
      fontFamily: 'Poppins',
    ),

    //text for small quote
    bodyMedium: TextStyle(
      color: AppColors.secondaryText,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
    ),

    //error style
    bodyLarge: TextStyle(
        color: AppColors.myRed,
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400),

    //normal black text
    headlineMedium: TextStyle(
        color: AppColors.primaryText,
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400),

    // company name style
    titleMedium: TextStyle(
      color: AppColors.primaryColor,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    ),

    // Title
    titleLarge: TextStyle(
      color: AppColors.primaryText,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    ),

    //info display
    displayMedium: TextStyle(
      color: AppColors.primaryText,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    ),

    //info titles
    displayLarge: TextStyle(
      color: AppColors.primaryText,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    ),
  ),

  //font
  fontFamily: 'Poppins',

  //pointer theme
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.mainColor, // Change the cursor color to blue
    selectionColor: AppColors.mainColor
        .withOpacity(0.4), // Text selection color (highlight)
    selectionHandleColor: Colors.blue, // The tear drop color
  ),

  cardTheme: CardTheme(
      color: AppColors.mainColor.withOpacity(0.5),
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(),
      margin: const EdgeInsets.only(bottom: 16),
      shadowColor: Colors.transparent),
);
