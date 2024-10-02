import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:patdoc/ui/views/patients/patients_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';

class PatientsView extends StatelessWidget {
  const PatientsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PatientsViewModel>.reactive(
      viewModelBuilder: () => PatientsViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => ModalProgressHUD(
        inAsyncCall: viewModel.isBusy,
        color: AppColors.primaryColor,
        progressIndicator: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Patients',
              style: AppStyles.blackW500(20),
            ),
            centerTitle: true,
            elevation: 1,
            backgroundColor: AppColors.whiteColor,
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: viewModel.patients.isEmpty
                  ? Center(
                      child: Text(
                        'No patients found',
                        style: AppStyles.blackW500(16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: viewModel.patients.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            child: Text(
                              viewModel.patients[index].firstName![0],
                              style: AppStyles.whiteW500(16),
                            ),
                          ),
                          title: Text(
                            viewModel.patients[index].firstName ?? '',
                            style: AppStyles.blackBold(16),
                          ),
                          subtitle: Text(viewModel.patients[index].email ?? ''),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
