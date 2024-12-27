import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/utils/styles.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {super.key,
      required this.title,
      required this.body,
      required this.actionButtonTitle,
      required this.onActionButtonPressed});

  final String title;
  final String body;
  final String actionButtonTitle;
  final Function onActionButtonPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: AppTextStyles.primaryTextStyle,
        textAlign: TextAlign.start,
      ),
      content: SingleChildScrollView(
        child: Text(
          body,
          textAlign: TextAlign.start,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      actions: <Widget>[
        Row(
          children: [
            // Expanded(
            //   child: TextButton(
            //     style: TextButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(4.0),
            //       ),
            //     ),
            //     child: const Text('Cancel',
            //         style: TextStyle(color: Colors.black, fontSize: 16)),
            //     onPressed: () => Navigator.of(context).pop(),
            //   ),
            // ),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: Text(
                  actionButtonTitle,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  // Handle logout logic
                  onActionButtonPressed();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
