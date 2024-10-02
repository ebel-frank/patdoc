import 'package:patdoc/app/app.router.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends IndexTrackingViewModel {
  Future<void> logout() async {
    await sharedPreferencesService.clearStorage();
    await sharedPreferencesService.setBool(keyIsUserOnboarded, true);
    navigationService.clearStackAndShow(Routes.loginView);
  }
}
