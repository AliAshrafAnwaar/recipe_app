import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';

class UserActionButton extends StatelessWidget {
  const UserActionButton({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(30),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: (MediaQuery.sizeOf(context).width * 0.3 <= 150)
                ? (MediaQuery.sizeOf(context).width * 0.3)
                : (150),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
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
