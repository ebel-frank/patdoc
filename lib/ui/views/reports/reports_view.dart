import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patdoc/ui/views/reports/reports_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/export.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportsViewModel>.nonReactive(
      viewModelBuilder: () => ReportsViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Report',
            style: AppStyles.blackW500(20),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: AppColors.whiteColor,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
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
              32.verticalSpace,
              Text(
                'Latest Report',
                style: AppStyles.blackBold(18),
              ),
              16.verticalSpace,
              Container(
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
                      SvgPicture.asset('assets/icons/file.svg'),
                      10.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Diabetes',
                            style: AppStyles.color2w500(16),
                          ),
                          4.verticalSpace,
                          Text(
                            'BGC Records',
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
            ],
          ),
        ),
      ),
    );
  }
}
