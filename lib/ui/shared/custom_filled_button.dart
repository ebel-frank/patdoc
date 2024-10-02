import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/styles.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          AppColors.primaryColor,
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 16.h),
        ),
        minimumSize: MaterialStatePropertyAll(
          Size(1.sw, 56),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      // statesController:
      child: Text(
        title,
        style: AppStyles.whiteBold(16),
      ),
    );
  }
}
