import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';

abstract class AppTextStyles {
  static TextStyle primaryTextStyle = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 22,
    color: AppColors.primaryText,
    fontWeight: FontWeight.w600,
  );

  static TextStyle secondaryTextStyle = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subTextStyle = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: AppColors.subText,
    fontWeight: FontWeight.w400,
  );
}
