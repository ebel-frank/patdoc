import 'package:flutter/material.dart';
import 'package:patdoc/utils/colors.dart';

class CustomFab extends StatelessWidget {
  const CustomFab({
    required this.onPressed,
    required this.isEnabled,
    super.key,
  });

  final void Function()? onPressed;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor:
          isEnabled ? AppColors.primaryColor : AppColors.whiteColor,
      elevation: isEnabled ? 6 : 0,
      shape: isEnabled
          ? null
          : const CircleBorder(
              side: BorderSide(
                color: AppColors.innerBorderColor,
              ),
            ),
      child: Icon(
        Icons.arrow_forward,
        color: isEnabled ? AppColors.whiteColor : AppColors.textColor4,
      ),
    );
  }
}
