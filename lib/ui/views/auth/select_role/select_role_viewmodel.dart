import 'package:patdoc/app/app.logger.dart';
import 'package:patdoc/app/app.router.dart';
import 'package:patdoc/utils/app_strings.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/enums.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class SelectRoleViewModel extends BaseViewModel {
  final log = getLogger('SelectRoleViewModel');

  bool _isPatientSelected = false;
  bool _isCareGiverSelected = false;
  bool _isPhysicianSelected = false;
  bool _isFabEnabled = false;

  bool get isPatient => _isPatientSelected;

  bool get isCareGiver => _isCareGiverSelected;

  bool get isPhysician => _isPhysicianSelected;

  bool get isFabEnabled => _isFabEnabled;

  void togglePatient() {
    if (_isPatientSelected) return;
    _isPatientSelected = !_isPatientSelected;
    _isCareGiverSelected = false;
    _isPhysicianSelected = false;
    _isFabEnabled = true;
    notifyListeners();
  }

  void toggleCareGiver() {
    if (_isCareGiverSelected) return;
    _isPatientSelected = false;
    _isCareGiverSelected = !_isCareGiverSelected;
    _isPhysicianSelected = false;
    _isFabEnabled = true;
    notifyListeners();
  }

  void togglePhysician() {
    if (_isPhysicianSelected) return;
    _isPatientSelected = false;
    _isCareGiverSelected = false;
    _isPhysicianSelected = !_isPhysicianSelected;
    _isFabEnabled = true;
    notifyListeners();
  }

  void navigateToSignIn() => navigationService.navigateToLoginView();

  String _getRole() {
    if (_isPatientSelected) return patient;
    if (_isCareGiverSelected) return caregiver;
    if (_isPhysicianSelected) return physician;
    return '';
  }

  void navigateToSignUp() async {
    if (!_isFabEnabled) {
      snackbarService.showCustomSnackBar(
        message: 'Please select a role to continue.',
        variant: SnackbarType.failure,
        duration: const Duration(seconds: 3),
      );
      return;
    }
    await sharedPreferencesService.setString(keyUserRole, _getRole());
    log.d('User role: ${sharedPreferencesService.getString(keyUserRole)}');
    navigationService.navigateToSignUpView();
  }
}
