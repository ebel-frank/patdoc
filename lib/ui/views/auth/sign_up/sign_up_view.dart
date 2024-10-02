import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:patdoc/ui/shared/custom_filled_button.dart';
import 'package:patdoc/ui/shared/custom_textfield.dart';
import 'package:patdoc/ui/views/auth/sign_up/sign_up_view.form.dart';
import 'package:patdoc/ui/views/auth/sign_up/sign_up_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(
  fields: [
    FormTextField(name: 'email'),
    FormTextField(name: 'password'),
  ],
)
class SignUpView extends StatelessWidget with $SignUpView {
  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      onViewModelReady: (viewModel) => syncFormWithViewModel(viewModel),
      builder: (context, viewModel, child) => ModalProgressHUD(
        inAsyncCall: viewModel.isBusy,
        color: AppColors.primaryColor,
        progressIndicator: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                48.verticalSpace,
                Text(
                  'PatDoc',
                  textAlign: TextAlign.center,
                  style: AppStyles.primaryBold(32.sp),
                ),
                32.verticalSpace,
                Text(
                  'Create an account',
                  textAlign: TextAlign.center,
                  style: AppStyles.secondaryBold(24.sp),
                ),
                8.verticalSpace,
                Text(
                  'Let\'s get you started. Please enter your details.',
                  textAlign: TextAlign.center,
                  style: AppStyles.color4Light(16.sp),
                ),
                32.verticalSpace,
                const Text('Email'),
                8.verticalSpace,
                CustomTextField(
                  textEditingController: emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'example@email.com',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/email.svg',
                    height: 15.w,
                    width: 15.w,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                20.verticalSpace,
                const Text('Password'),
                8.verticalSpace,
                CustomTextField(
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/lock.svg',
                    height: 15.w,
                    width: 15.w,
                    fit: BoxFit.scaleDown,
                  ),
                  textEditingController: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  labelText: '8 characters minimum',
                  obscureText: viewModel.obscureText,
                  onSuffixIconPressed: viewModel.togglePasswordVisibility,
                ),
                38.verticalSpace,
                CustomFilledButton(
                  title: 'Continue',
                  onPressed: viewModel.signUp,
                ),
                40.verticalSpace,
                Text(
                  'By clicking "Continue", you agree to accept our',
                  textAlign: TextAlign.center,
                  style: AppStyles.color4Light(16.sp),
                ),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Privacy Policy ',
                      textAlign: TextAlign.center,
                      style: AppStyles.primaryBold(16.sp),
                    ),
                    Text(
                      'and',
                      textAlign: TextAlign.center,
                      style: AppStyles.color4Light(16.sp),
                    ),
                    Text(
                      ' Terms of Service',
                      textAlign: TextAlign.center,
                      style: AppStyles.primaryBold(16.sp),
                    ),
                  ],
                ),
                48.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppStyles.color4Light(16.sp),
                    ),
                    TextButton(
                      onPressed: viewModel.navigateToSignIn,
                      child: Text(
                        'Sign In',
                        style: AppStyles.primaryBold(16.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
