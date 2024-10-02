import 'package:flutter/material.dart';
import 'package:patdoc/app/app.router.dart';
import 'package:patdoc/models/remotics_user.dart';
import 'package:patdoc/ui/views/messages/messages_list/messages_list_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/export.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessagesListViewModel>.reactive(
      viewModelBuilder: () => MessagesListViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Messages',
            style: AppStyles.blackW500(20),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: AppColors.whiteColor,
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder<List<RemoticsUser>>(
          stream: firestoreService.listenToPhysicianPatients(
              physicianUid: viewModel.physicianUid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<RemoticsUser>? patients = snapshot.data;

              if (patients!.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      'No Patients Yet ',
                      style: AppStyles.color1W500(16),
                    ),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      sharedPreferencesService.setString(keyCurrentUserChatId,
                          '${patients[index].firstName} ${patients[index].lastName}');
                      navigationService.navigateToMessagesView();
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Image.asset('assets/images/avatar.jpg'),
                      ),
                      title: Text(
                        '${patients[index].firstName} ${patients[index].lastName}',
                        style: AppStyles.blackW500(16),
                      ),
                      subtitle: const Text('...'),
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
      ),
    );
  }
}
