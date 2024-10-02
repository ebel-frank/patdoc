import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patdoc/ui/shared/custom_fab.dart';
import 'package:patdoc/ui/shared/custom_filled_button.dart';
import 'package:patdoc/ui/shared/custom_unfilled_button.dart';
import 'package:patdoc/ui/views/auth/onboarding/onboarding_viewmodel.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      viewModelBuilder: () => OnboardingViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: viewModel.currentIndex == 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset('assets/icons/onboarding_one.svg'),
                  82.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 42.0),
                    child: Text(
                      'Welcome to \nyour trusted \nhealthcare \ncompanion',
                      style: AppStyles.primaryBold(36.sp),
                    ),
                  )
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    57.verticalSpace,
                    Text(
                      'You health care at your \nfingertips',
                      style: AppStyles.secondaryBold(24),
                      textAlign: TextAlign.center,
                    ),
                    63.verticalSpace,
                    SvgPicture.asset(
                      'assets/icons/patient.svg',
                      height: 300.h,
                    ),
                    110.verticalSpace,
                    Column(
                      children: [
                        CustomFilledButton(
                          title: 'Sign In',
                          onPressed: viewModel.navigateToLogin,
                        ),
                        12.verticalSpace,
                        CustomUnfilledButton(
                          title: 'Create an account',
                          onPressed: viewModel.navigateToSignUp,
                        ),
                        20.verticalSpace,
                      ],
                    ),
                  ],
                ),
              ),
        floatingActionButton: viewModel.currentIndex == 0
            ? CustomFab(
                onPressed: viewModel.showOnboardingTwo,
                isEnabled: true,
              )
            : null,
      ),
    );
  }
}
