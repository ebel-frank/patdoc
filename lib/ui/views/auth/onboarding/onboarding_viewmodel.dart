import 'package:patdoc/app/app.router.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class OnboardingViewModel extends BaseViewModel {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void navigateToLogin() => navigationService.navigateToLoginView();

  void navigateToSignUp() => navigationService.navigateToSelectRoleView();

  void showOnboardingTwo() async {
    _currentIndex = 1;
    await sharedPreferencesService.setBool(keyIsUserOnboarded, true);
    notifyListeners();
  }
}
