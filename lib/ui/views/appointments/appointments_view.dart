import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patdoc/models/appointment.dart';
import 'package:patdoc/ui/views/appointments/appointments_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/export.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentsViewModel>.nonReactive(
      viewModelBuilder: () => AppointmentsViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Appointments',
            style: AppStyles.blackW500(20),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: AppColors.whiteColor,
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
              Text(
                'Your Appointments',
                style: AppStyles.color2w500(16),
              ),
              8.verticalSpace,
              StreamBuilder<List<Appointment>>(
                stream: firestoreService.listenToAppointments(
                    physicianUid: viewModel.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Appointment>? appointments = snapshot.data;
                    //if the current user is a physician, then show the list of appointments
                    //else, loop through the list of appointments using viewModel.uid to get the current user's appointments
                    appointments = viewModel.isPhysician
                        ? appointments
                        : appointments!
                            .where((element) =>
                                element.patientUid == viewModel.uid)
                            .toList();
                    if (appointments!.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            'No appointments today',
                            style: AppStyles.color1W500(16),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
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
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.primaryShade2,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4.0,
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        'Video Consultation',
                                        style: AppStyles.primaryNormal(12),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    appointments![index].patientName ?? 'User',
                                    style: AppStyles.color2w500(16),
                                  ),
                                  4.verticalSpace,
                                  Row(
                                    children: [
                                      Text(
                                        appointments[index].time ?? 'TimeXX',
                                        style: AppStyles.color1W500(16),
                                      ),
                                      8.horizontalSpace,
                                      Text(
                                        appointments[index].date ?? 'DateXX',
                                        style: AppStyles.color1W500(16),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              SvgPicture.asset(
                                'assets/icons/video_conferencing.svg',
                                height: 40.h,
                                width: 40.h,
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    // Handle any errors
                    return Text(
                      'Error 😔',
                      style: AppStyles.progressRedNormal(14.0),
                    );
                  } else {
                    // Show a loading indicator while waiting for data
                    return const CircularProgressIndicator();
                  }
                },
              ),
              8.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
