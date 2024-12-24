import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';

class UserActionButton extends StatelessWidget {
  const UserActionButton({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.mainColor.withOpacity(0.5)),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
