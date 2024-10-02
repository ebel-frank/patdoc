import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:patdoc/ui/shared/custom_filled_button.dart';
import 'package:patdoc/ui/shared/custom_unfilled_button.dart';
import 'package:patdoc/ui/views/token/generate_token_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';

class GenerateTokenView extends StatelessWidget {
  const GenerateTokenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GenerateTokenViewModel>.reactive(
      viewModelBuilder: () => GenerateTokenViewModel(),
      builder: (context, viewModel, child) => ModalProgressHUD(
        inAsyncCall: viewModel.isBusy,
        color: AppColors.primaryColor,
        progressIndicator: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Generate Token',
              style: AppStyles.blackW500(20),
            ),
            centerTitle: true,
            elevation: 1,
            backgroundColor: AppColors.whiteColor,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: viewModel.logout,
                icon: const Icon(Icons.logout, color: AppColors.progressRed),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Generated Token: \n ${viewModel.generatedToken}',
                    textAlign: TextAlign.center,
                    style: AppStyles.primaryBold(16),
                  ),
                  24.verticalSpace,
                  CustomFilledButton(
                    title: 'Generate Token',
                    onPressed: viewModel.generateToken,
                  ),
                  24.verticalSpace,
                  CustomUnfilledButton(
                    title: 'Save Token',
                    onPressed: viewModel.saveTokenToFirebase,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
