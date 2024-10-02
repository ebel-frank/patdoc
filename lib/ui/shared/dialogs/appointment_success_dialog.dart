import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patdoc/app/app.router.dart';
import 'package:patdoc/ui/shared/custom_filled_button.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/export.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked_services/stacked_services.dart';

class AppointmentSuccessDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const AppointmentSuccessDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: _AppointmentSuccessDialogContent(
        request: request,
        completer: completer,
      ),
    );
  }
}

class _AppointmentSuccessDialogContent extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const _AppointmentSuccessDialogContent({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: const EdgeInsets.all(20),
      width: 400.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/avatar.jpg',
          ),
          16.verticalSpace,
          Text(
            'Your upcoming virtual meeting with ${request.description} has been scheduled.',
            style: AppStyles.color1W500(20),
            textAlign: TextAlign.center,
          ),
          16.verticalSpace,
          Text(
            request.data,
            style: AppStyles.color4Normal(14),
            textAlign: TextAlign.center,
          ),
          52.verticalSpace,
          InkWell(
            onTap: () =>
                navigationService.navigateTo(Routes.bookAppointmentView),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 16.0,
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/calendar_bordered.svg'),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Schedule new Appointment',
                        style: AppStyles.color2w500(14),
                      ),
                      4.verticalSpace,
                      Text(
                        'Schedule new appointment \nwith your doctor.',
                        style: AppStyles.color4Normal(14),
                      )
                    ],
                  ),
                  const Spacer(),
                  SvgPicture.asset('assets/icons/next.svg'),
                ],
              ),
            ),
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomFilledButton(
                  title: 'Appointments',
                  onPressed: () => navigationService.popRepeated(2),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
