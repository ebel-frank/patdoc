import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:patdoc/ui/shared/custom_filled_button.dart';
import 'package:patdoc/ui/shared/custom_textfield.dart';
import 'package:patdoc/ui/views/auth/sign_up_details/sign_up_details_view.form.dart';
import 'package:patdoc/ui/views/auth/sign_up_details/sign_up_details_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(
  fields: [
    FormTextField(name: 'firstName'),
    FormTextField(name: 'lastName'),
    FormTextField(name: 'phoneNumber'),
    FormTextField(name: 'year'),
    FormTextField(name: 'day'),
    FormTextField(name: 'token'),
  ],
)
class SignUpDetailsView extends StatelessWidget with $SignUpDetailsView {
  SignUpDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpDetailsViewModel>.reactive(
      viewModelBuilder: () => SignUpDetailsViewModel(),
      onViewModelReady: (viewModel) {
        syncFormWithViewModel(viewModel);
        viewModel.getAllTokensFromFirestore();
      },
      builder: (context, viewModel, child) => ModalProgressHUD(
        inAsyncCall: viewModel.isBusy,
        color: AppColors.primaryColor,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                48.verticalSpace,
                Text(
                  'Basic Information',
                  textAlign: TextAlign.center,
                  style: AppStyles.secondaryBold(24.sp),
                ),
                8.verticalSpace,
                Text(
                  'Please tell us some basic information to complete your profile:',
                  style: AppStyles.color4Light(16.sp),
                ),
                32.verticalSpace,
                const Text('First Name'),
                8.verticalSpace,
                CustomTextField(
                  textEditingController: firstNameController,
                  keyboardType: TextInputType.name,
                  labelText: 'First Name',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/account.svg',
                    height: 15.w,
                    width: 15.w,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                20.verticalSpace,
                const Text('Last Name'),
                8.verticalSpace,
                CustomTextField(
                  textEditingController: lastNameController,
                  keyboardType: TextInputType.name,
                  labelText: 'Last Name',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/account.svg',
                    height: 15.w,
                    width: 15.w,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Visibility(
                  visible: !viewModel.isPhysician,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.verticalSpace,
                      const Text('Date of birth'),
                      8.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                  left: 16,
                                  top: 12,
                                  bottom: 12,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.innerBorderColor,
                                  ),
                                ),
                              ),
                              value: 'January',
                              items: viewModel.months
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: viewModel.changeSelectedMonth,
                            ),
                          ),
                          6.horizontalSpace,
                          Expanded(
                            flex: 2,
                            child: CustomTextField(
                              textEditingController: dayController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: false,
                                signed: false,
                              ),
                              labelText: 'Day',
                              // validator: viewModel.validateDay,
                            ),
                          ),
                          6.horizontalSpace,
                          Expanded(
                            flex: 2,
                            child: CustomTextField(
                              textEditingController: yearController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: false,
                                signed: false,
                              ),
                              labelText: 'Year',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                const Text('Phone Number'),
                8.verticalSpace,
                CustomTextField(
                  textEditingController: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  labelText: '+234 (999) 000-0000',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/account.svg',
                    height: 15.w,
                    width: 15.w,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                20.verticalSpace,
                const Text('Gender'),
                8.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.disabledColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            elevation: viewModel.isMale ? 4 : 0,
                            padding: EdgeInsets.zero,
                            backgroundColor: viewModel.isMale
                                ? AppColors.whiteColor
                                : AppColors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: viewModel.toggleGender,
                          child: Text(
                            'Male',
                            style: TextStyle(
                              color: viewModel.isMale
                                  ? AppColors.blackColor
                                  : AppColors.innerBorderColor,
                            ),
                          ),
                        ),
                      ),
                      4.horizontalSpace,
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: viewModel.isFemale ? 4 : 0,
                            padding: const EdgeInsets.all(0),
                            backgroundColor: viewModel.isFemale
                                ? AppColors.whiteColor
                                : AppColors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: viewModel.toggleGender,
                          child: Text(
                            'Female',
                            style: TextStyle(
                              color: viewModel.isFemale
                                  ? AppColors.blackColor
                                  : AppColors.innerBorderColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !viewModel.isPhysician,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.verticalSpace,
                      const Text('Token'),
                      8.verticalSpace,
                      CustomTextField(
                        textEditingController: tokenController,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: '- - - - - -',
                      ),
                    ],
                  ),
                ),
                38.verticalSpace,
                CustomFilledButton(
                  title: 'Save',
                  onPressed: viewModel.saveUserDetailsToFirestore,
                ),
                40.verticalSpace,
                Text(
                  'By providing your mobile number, you give us permission to contact you via text.',
                  textAlign: TextAlign.center,
                  style: AppStyles.color4Light(16.sp),
                ),
                48.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
