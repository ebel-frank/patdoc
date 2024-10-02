import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patdoc/ui/shared/custom_fab.dart';
import 'package:patdoc/ui/views/auth/select_role/select_role_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';

class SelectRoleView extends StatelessWidget {
  const SelectRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectRoleViewModel>.reactive(
      viewModelBuilder: () => SelectRoleViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              48.verticalSpace,
              Text(
                'Select your role to create an account',
                textAlign: TextAlign.center,
                style: AppStyles.secondaryBold(24.sp),
              ),
              74.verticalSpace,
              RoleCard(
                roleTitle: 'Patient',
                isSelected: viewModel.isPatient,
                onTap: viewModel.togglePatient,
              ),
              12.verticalSpace,
              RoleCard(
                roleTitle: 'Caregiver',
                isSelected: viewModel.isCareGiver,
                onTap: viewModel.toggleCareGiver,
              ),
              12.verticalSpace,
              RoleCard(
                roleTitle: 'Physician',
                isSelected: viewModel.isPhysician,
                onTap: viewModel.togglePhysician,
              ),
              82.verticalSpace,
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
        floatingActionButton: CustomFab(
          isEnabled: viewModel.isFabEnabled,
          onPressed: viewModel.navigateToSignUp,
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.roleTitle,
  });

  final void Function() onTap;
  final bool isSelected;
  final String roleTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.primaryColor : AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            roleTitle,
            style: isSelected
                ? AppStyles.whiteBold(16.sp)
                : AppStyles.color2w500(16.sp),
          ),
        ),
      ),
    );
  }
}
