import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:patdoc/ui/shared/custom_filled_button.dart';
import 'package:patdoc/ui/shared/custom_textfield.dart';
import 'package:patdoc/ui/views/auth/login/login_view.form.dart';
import 'package:patdoc/ui/views/auth/login/login_viewmodel.dart';
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
class LoginView extends StatelessWidget with $LoginView {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onViewModelReady: (viewModel) => syncFormWithViewModel(viewModel),
      builder: (context, viewModel, child) => ModalProgressHUD(
        inAsyncCall: viewModel.isBusy,
        color: AppColors.primaryColor,
        progressIndicator: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      'Sign in to your account',
                      textAlign: TextAlign.center,
                      style: AppStyles.secondaryBold(24.sp),
                    ),
                    8.verticalSpace,
                    Text(
                      'Welcome back! You have been missed.',
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
                      labelText: 'Enter your password',
                      obscureText: viewModel.obscureText,
                      onSuffixIconPressed: viewModel.togglePasswordVisibility,
                    ),
                    38.verticalSpace,
                    Row(
                      children: [
                        Checkbox(
                          value: viewModel.rememberMe,
                          onChanged: (value) => viewModel.toggleRememberMe,
                          activeColor: AppColors.primaryColor,
                          side: BorderSide(
                            color: AppColors.primaryColor,
                            width: 1.w,
                            style: BorderStyle.solid,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        Text(
                          'Remember',
                          style: AppStyles.color1Bold(14.sp),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: AppStyles.accent500(14.sp),
                          ),
                        ),
                      ],
                    ),
                    38.verticalSpace,
                    CustomFilledButton(
                      title: 'Sign In',
                      onPressed: viewModel.login,
                    ),
                    40.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: AppStyles.color4Light(16.sp),
                        ),
                        TextButton(
                          onPressed: viewModel.navigateToSelectRole,
                          child: Text(
                            'Sign Up',
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
        ),
      ),
    );
  }
}
