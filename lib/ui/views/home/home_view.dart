import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patdoc/ui/views/home/home_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/export.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, this.name}) : super(key: key);
  final String? name;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        body: SafeArea(
          child: viewModel.isPhysician
              ? PhysicianHomeView(
                  viewModel: viewModel,
                )
              : PatientHomeView(
                  viewModel: viewModel,
                ),
        ),
      ),
    );
  }
}

class PhysicianHomeView extends StatelessWidget {
  const PhysicianHomeView({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      32.verticalSpace,
                      Text(
                        'Hi, Dr ${viewModel.firstName}!',
                        style: AppStyles.color2w500(20),
                      ),
                      Text(
                        'Welcome back',
                        style: AppStyles.color4Normal(16),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    // onTap: viewModel.getData,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 10.25,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/notification.svg',
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              26.verticalSpace,
              Text('Upcoming checks', style: AppStyles.blackBold(18)),
              15.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xE31E6B7B),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xAB2EBFDF),
                        ),
                        width: 92,
                        height: 98,
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Text(
                            '25 Wed',
                            textAlign: TextAlign.center,
                            style: AppStyles.whiteBold(18),
                          ),
                        ),
                      ),
                      24.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '09:30 AM',
                            style: AppStyles.whiteNormal(10),
                          ),
                          8.verticalSpace,
                          Text(
                            'BGC Check',
                            style: AppStyles.whiteW500(15),
                          ),
                          8.verticalSpace,
                          Text(
                            'Non-Invasive',
                            style: AppStyles.whiteBold(10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              26.verticalSpace,
              InkWell(
                onTap: viewModel.navigateToAppointmentsView,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0x665FC8DF),
                      width: 1,
                    ),
                  ),
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
                          children: [
                            Text(
                              'Check Appointments',
                              style: AppStyles.color2w500(16),
                            ),
                            4.verticalSpace,
                            Text(
                              'Check all your appointments.',
                              style: AppStyles.color4Normal(14),
                            )
                          ],
                        ),
                        10.horizontalSpace,
                        const Spacer(),
                        SvgPicture.asset('assets/icons/next.svg'),
                        8.horizontalSpace,
                      ],
                    ),
                  ),
                ),
              ),
              8.verticalSpace,
              GestureDetector(
                onTap: viewModel.navigateToPatientsView,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0x665FC8DF),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/access_patients.svg'),
                        10.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Access Patients',
                                style: AppStyles.color2w500(16),
                              ),
                              4.verticalSpace,
                              Text(
                                'Cross check patients health and state',
                                style: AppStyles.color4Normal(14),
                              )
                            ],
                          ),
                        ),
                        10.horizontalSpace,
                        SvgPicture.asset('assets/icons/next.svg'),
                        8.horizontalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PatientHomeView extends StatelessWidget {
  const PatientHomeView({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      32.verticalSpace,
                      Text(
                        'Hi, ${viewModel.firstName}!',
                        style: AppStyles.color2w500(20),
                      ),
                      Text(
                        'Welcome back',
                        style: AppStyles.color4Normal(16),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    // onTap: viewModel.getData,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 10.25,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/notification.svg',
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              26.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0x665FC8DF),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 40.0,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Blood sugar',
                            style: AppStyles.blackNormal(14),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              StreamBuilder<Map<Object?, Object?>>(
                                stream: firebaseRtdbService
                                    .listenForScannedListUpdates(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    /*final scannedList = snapshot.data;
                                    if (viewModel.oldData!.isEmpty) {
                                      viewModel.oldData = scannedList;
                                    }
                                    //find the latest scanned value
                                    //compare the old data with the new data
                                    //if the new data is different from the old data,
                                    //then find the value that is different
                                    //and update the UI with the new value
                                    //then set oldData to the new data
                                    viewModel.log
                                        .d('oldData: ${viewModel.oldData}');
                                    viewModel.log
                                        .d('scannedList: $scannedList');
                                    List<String> changedKeys = [];
                                    scannedList!.forEach((key, value) {
                                      if (viewModel.oldData![key] != value) {
                                        changedKeys.add(key.toString());
                                      }
                                    });
                                    String key = 'one';
                                    if (changedKeys.isNotEmpty) {
                                      viewModel.log.d(
                                          'The following keys have changed: $changedKeys');
                                      viewModel.oldData = scannedList;
                                      key = changedKeys[0];
                                    } else {
                                      viewModel.log.d('No changes detected.');
                                    }
                                    return Text(
                                      scannedList[key].toString(),
                                      style: AppStyles.blackBold(30.0),
                                    );*/
                                    final glucometer = snapshot.data as Map;
                                    return Text(
                                      "${glucometer['glucoseLevel']}",
                                      style: AppStyles.blackBold(30.0),
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
                              Text(
                                ' mg/dL',
                                style: AppStyles.blackNormal(14.0),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      SvgPicture.asset('assets/icons/ecg.svg'),
                    ],
                  ),
                ),
              ),
              26.verticalSpace,
              Text('Upcoming checks', style: AppStyles.blackBold(18)),
              15.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xE31E6B7B),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xAB2EBFDF),
                        ),
                        width: 92,
                        height: 98,
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Text(
                            '25 Wed',
                            textAlign: TextAlign.center,
                            style: AppStyles.whiteBold(18),
                          ),
                        ),
                      ),
                      24.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '09:30 AM',
                            style: AppStyles.whiteNormal(10),
                          ),
                          8.verticalSpace,
                          Text(
                            'BGC Check',
                            style: AppStyles.whiteW500(15),
                          ),
                          8.verticalSpace,
                          Text(
                            'Non-Invasive',
                            style: AppStyles.whiteBold(10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              26.verticalSpace,
              InkWell(
                onTap: viewModel.navigateToBookAppointmentView,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0x665FC8DF),
                      width: 1,
                    ),
                  ),
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
                          children: [
                            Text(
                              'Book an Appointment',
                              style: AppStyles.color2w500(16),
                            ),
                            4.verticalSpace,
                            Text(
                              'Book an appointment and chat by \nvideo with your doctor.',
                              style: AppStyles.color4Normal(14),
                            )
                          ],
                        ),
                        10.horizontalSpace,
                        const Spacer(),
                        SvgPicture.asset('assets/icons/next.svg'),
                        8.horizontalSpace,
                      ],
                    ),
                  ),
                ),
              ),
              8.verticalSpace,
              GestureDetector(
                onTap: viewModel.openDialer,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0x665FC8DF),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            'assets/icons/urgent_care_bordered.svg'),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Request Urgent Care',
                              style: AppStyles.color2w500(16),
                            ),
                            4.verticalSpace,
                            Text(
                              'Call  hospital emergency unit',
                              style: AppStyles.color4Normal(14),
                            )
                          ],
                        ),
                        10.horizontalSpace,
                        const Spacer(),
                        SvgPicture.asset('assets/icons/next.svg'),
                        8.horizontalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
