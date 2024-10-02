import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patdoc/ui/views/auth/splashscreen/splashscreen_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:stacked/stacked.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      viewModelBuilder: () => SplashScreenViewModel(),
      onViewModelReady: (model) => model.navigateToOnboarding(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              SvgPicture.asset('assets/icons/remotics_logo.svg'),
              const Positioned(
                bottom: 50,
                child: Text(
                  'PatDoc',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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
