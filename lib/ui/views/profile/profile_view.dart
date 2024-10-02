import 'package:flutter/material.dart';
import 'package:patdoc/ui/views/profile/profile_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.nonReactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: AppStyles.blackW500(20),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: AppColors.whiteColor,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: viewModel.logout,
              icon: const Icon(Icons.logout, color: AppColors.progressRed),
            ),
          ],
        ),
        body: const Center(
          child: Text('Hello ProfileView!'),
        ),
      ),
    );
  }
}
