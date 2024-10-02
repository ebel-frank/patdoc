import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:patdoc/ui/shared/custom_filled_button.dart';
import 'package:patdoc/ui/views/home/book_appointment/book_appointment_view.form.dart';
import 'package:patdoc/ui/views/home/book_appointment/book_appointment_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(
  fields: [
    FormTextField(name: 'note'),
  ],
)
class BookAppointmentView extends StatelessWidget with $BookAppointmentView {
  BookAppointmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookAppointmentViewModel>.reactive(
      viewModelBuilder: () => BookAppointmentViewModel(),
      onViewModelReady: (viewModel) => syncFormWithViewModel(viewModel),
      builder: (context, viewModel, child) => ModalProgressHUD(
        inAsyncCall: viewModel.isBusy,
        color: AppColors.primaryColor,
        progressIndicator: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: AppColors.primaryColor,
            ),
            backgroundColor: AppColors.whiteColor,
            title: Text(
              'Book an Appointment',
              style: AppStyles.blackW500(20),
            ),
            elevation: 1,
            automaticallyImplyLeading: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.verticalSpace,
                  Text(
                    'Confirm a date and time for your appointment with a general practitioner. Include a note as well',
                    style: AppStyles.color4Normal(16),
                  ),
                  40.verticalSpace,
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/avatar.jpg',
                        height: 40.h,
                        width: 40.h,
                      ),
                      16.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. ${viewModel.physicianName}',
                            style: AppStyles.color2w500(16),
                          ),
                          4.verticalSpace,
                          Text(
                            'MBBS, BCS, MD (Medical Officer)',
                            style: AppStyles.color4Normal(14),
                          )
                        ],
                      )
                    ],
                  ),
                  16.verticalSpace,
                  const Divider(
                    thickness: 1,
                  ),
                  32.verticalSpace,
                  Text(
                    'DATE AND TIME',
                    style: AppStyles.color4W500(14),
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      InkWell(
                        onTap: () => showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light().copyWith(
                                  primary: AppColors.primaryColor,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        ).then(
                          (value) {
                            if (value != null) {
                              viewModel.setDate(value);
                            }
                          },
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.greyColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Text(
                            viewModel.date,
                            style: AppStyles.color1W500(16),
                          ),
                        ),
                      ),
                      25.horizontalSpace,
                      const SizedBox(
                        width: 1,
                        height: 20,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      25.horizontalSpace,
                      InkWell(
                        onTap: () => showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light().copyWith(
                                  primary: AppColors.primaryColor,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        ).then(
                          (value) {
                            if (value != null) {
                              viewModel.setTime(value);
                            }
                          },
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.greyColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Text(
                            viewModel.time,
                            style: AppStyles.color1W500(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  32.verticalSpace,
                  const Divider(
                    thickness: 1,
                  ),
                  24.verticalSpace,
                  Text(
                    'NOTE',
                    style: AppStyles.color4W500(14),
                  ),
                  8.verticalSpace,
                  Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.greyColor,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: TextField(
                      controller: noteController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your complaints...',
                        hintStyle: AppStyles.color4Normal(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: AppColors.greyColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(
                  thickness: 2,
                  height: 0,
                ),
                32.verticalSpace,
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomFilledButton(
                    title: 'Book',
                    onPressed: viewModel.bookAppointment,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
