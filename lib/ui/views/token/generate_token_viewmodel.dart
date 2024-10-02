import 'package:patdoc/app/app.logger.dart';
import 'package:patdoc/app/app.router.dart';
import 'package:patdoc/models/token.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/enums.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class GenerateTokenViewModel extends BaseViewModel {
  final log = getLogger('GenerateTokenViewModel');

  String generatedToken = '------';
  bool _alreadyGenerated = false;

  //generates a token (6-digit number) for the patient
  void generateToken() {
    _alreadyGenerated = false;
    int token = DateTime.now().millisecondsSinceEpoch % 1000000;
    log.d('token: $token');
    //to make sure the token is 6 digits long
    if (token < 100000) {
      log.e('token is less than 6 digits long, adding 100000 to it.');
      log.e('Token was $token, at ${token.toString().length} digits long.');

      token += 100000;
    }
    //convert the token to a string of 6 digits
    generatedToken = token.toString().substring(0, 6);
    notifyListeners();
  }

  Future<void> saveTokenToFirebase() async {
    if (generatedToken != '------') {
      if (_alreadyGenerated) {
        snackbarService.showCustomSnackBar(
          message: 'Token already saved.',
          variant: SnackbarType.failure,
        );
        return;
      }
      //The physician is the one currently logged in (and the only user that can access this screen) so his details are the ones in the sharedPref
      String physicianEmail =
          sharedPreferencesService.getString(keyEmail) ?? '';
      String physicianUid = sharedPreferencesService.getString(keyUid) ?? '';
      String physicianFirstName =
          sharedPreferencesService.getString(keyFirstName) ?? '';
      String physicianLastName =
          sharedPreferencesService.getString(keyLastName) ?? '';
      String fullName = '$physicianFirstName $physicianLastName';

      if (physicianEmail != '') {
        setBusy(true);
        Token token = Token(
            token: generatedToken,
            physicianEmail: physicianEmail,
            physicianUid: physicianUid,
            physicianFullName: fullName);
        bool isSuccessful =
            await firestoreService.saveTokenToFirebase(token: token);
        log.d('isSuccessful: $isSuccessful');
        if (isSuccessful) {
          _alreadyGenerated = true;
          snackbarService.showCustomSnackBar(
            message: 'Token successfully saved.',
            variant: SnackbarType.success,
          );
        } else {
          snackbarService.showCustomSnackBar(
            message: 'Token could not be saved.',
            variant: SnackbarType.failure,
          );
        }
        setBusy(false);
      } else {
        log.d('physicianEmail is empty');
      }
    } else {
      log.d('generatedToken is empty');
      snackbarService.showCustomSnackBar(
        message: 'Please, generate a token first.',
        variant: SnackbarType.failure,
      );
    }
  }

  Future<void> logout() async {
    await sharedPreferencesService.clearStorage();
    await sharedPreferencesService.setBool(keyIsUserOnboarded, true);
    navigationService.clearStackAndShow(Routes.loginView);
  }
}
