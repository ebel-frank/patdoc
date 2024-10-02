import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/styles.dart';

class CustomUnfilledButton extends StatelessWidget {
  const CustomUnfilledButton({
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
          AppColors.whiteColor,
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
            side: const BorderSide(
              color: AppColors.buttonBorder,
              width: 1,
            ),
          ),
        ),
        splashFactory: InkSplash.splashFactory,
        surfaceTintColor: MaterialStateProperty.all(
          AppColors.primaryColor,
        ),
      ),
      child: Text(
        title,
        style: AppStyles.blackBold(16),
      ),
    );
  }
}
