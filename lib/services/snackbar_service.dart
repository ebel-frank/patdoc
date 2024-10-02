import 'package:flutter/material.dart';
import 'package:patdoc/app/app.locator.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/enums.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbar() {
  final service = locator<SnackbarService>();

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.success,
    config: SnackbarConfig(
      padding: const EdgeInsets.all(10),
      backgroundColor: Colors.green,
      textColor: AppColors.whiteColor,
      borderRadius: 5,
      dismissDirection: DismissDirection.horizontal,
      //titleText: const Icon(Icons.check),
      // animationDuration: const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 20, bottom: 0, right: 20, left: 20),
      barBlur: 0.6,
      messageColor: AppColors.whiteColor,
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.failure,
    config: SnackbarConfig(
      backgroundColor: AppColors.progressRed,
      textColor: AppColors.whiteColor,
      borderRadius: 1,
      dismissDirection: DismissDirection.horizontal,
      // animationDuration: const Duration(seconds: 3),
      margin: const EdgeInsets.only(bottom: 0, right: 0, left: 0),
      barBlur: 0.6,
      messageColor: AppColors.whiteColor,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
    ),
  );
}
