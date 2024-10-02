import 'package:patdoc/app/app.router.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class SplashScreenViewModel extends BaseViewModel {
  void navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isUserOnboarded =
        sharedPreferencesService.getBool(keyIsUserOnboarded) ?? false;
    bool isLoggedIn = sharedPreferencesService.getBool(keyIsLoggedIn) ?? false;
    if (isUserOnboarded && !isLoggedIn) {
      navigationService.clearStackAndShow(Routes.loginView);
      return;
    } else if (isLoggedIn) {
      navigationService.clearStackAndShow(Routes.navBarView);
      return;
    } else {
      navigationService.clearStackAndShow(Routes.onboardingView);
    }
  }
}
