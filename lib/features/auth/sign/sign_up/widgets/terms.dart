import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';
import 'package:recipe_app/core/constants/strings.dart';
import 'package:recipe_app/features/shared_widgets/custum_alert_dialog.dart';

void showTermsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => CustomAlertDialog(
      title: 'Terms and Conditions',
      body: AppStrings.termsAndConditions,
      actionButtonTitle: 'Done',
      onActionButtonPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );
}

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          child: Text(
            "By clicking Register, you agree to our",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextButton(
          onPressed: () {
            showTermsDialog(context);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            ' Terms and conditions',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
