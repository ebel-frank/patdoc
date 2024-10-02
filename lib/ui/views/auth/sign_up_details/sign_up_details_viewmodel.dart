import 'package:patdoc/app/app.logger.dart';
import 'package:patdoc/app/app.router.dart';
import 'package:patdoc/models/remotics_user.dart';
import 'package:patdoc/models/token.dart';
import 'package:patdoc/ui/views/auth/sign_up_details/sign_up_details_view.form.dart';
import 'package:patdoc/utils/app_strings.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/enums.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class SignUpDetailsViewModel extends FormViewModel {
  final log = getLogger('SignUpDetailsViewModel');
  final bool isPhysician =
      sharedPreferencesService.getString(keyUserRole) == physician;

  bool _isMale = true;
  bool _isFemale = false;

  bool get isMale => _isMale;

  bool get isFemale => _isFemale;

  String selectedMonth = 'January';
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  List<Token> allTokens = [];

  Future<void> getAllTokensFromFirestore() async {
    if (isPhysician) return;
    setBusy(true);
    allTokens = await firestoreService.getAllTokensFromFirestore();
    setBusy(false);
  }

  void changeSelectedMonth(String? month) {
    selectedMonth = month ?? 'January';
  }

  void navigateToNavBarView() async {
    await sharedPreferencesService.setBool(keyIsLoggedIn, true);
    navigationService.clearStackAndShow(Routes.navBarView);
  }

  void toggleGender() {
    _isMale = !_isMale;
    _isFemale = !_isFemale;
    notifyListeners();
  }

  String _getGender() {
    if (_isMale) return 'male';
    if (_isFemale) return 'female';
    return '';
  }

  String _getDateOfBirth() {
    return '$selectedMonth $dayValue, $yearValue';
  }

  Future<void> saveUserDetailsToFirestore() async {
    if (isPhysician) {
      if (firstNameValue == '' ||
          lastNameValue == '' ||
          phoneNumberValue == '' ||
          firstNameValue == null ||
          lastNameValue == null ||
          phoneNumberValue == null) {
        snackbarService.showCustomSnackBar(
          message: 'Please fill in all fields',
          variant: SnackbarType.failure,
        );
        return;
      }
    } else {
      if (firstNameValue == '' ||
          lastNameValue == '' ||
          phoneNumberValue == '' ||
          dayValue == '' ||
          yearValue == '' ||
          tokenValue == '' ||
          firstNameValue == null ||
          lastNameValue == null ||
          phoneNumberValue == null ||
          dayValue == null ||
          yearValue == null ||
          tokenValue == null) {
        snackbarService.showCustomSnackBar(
          message: 'Please fill in all fields',
          variant: SnackbarType.failure,
        );
        return;
      }
    }
    String? physicianUid;
    if (!isPhysician) {
      if (int.parse(dayValue!) > 31 ||
          int.parse(dayValue!) < 1 ||
          int.parse(yearValue!) > DateTime.now().year ||
          int.parse(yearValue!) < 1900) {
        snackbarService.showCustomSnackBar(
          message: 'Please enter a valid day or year.',
          variant: SnackbarType.failure,
        );
        return;
      }

      //Go through the tokens list and find the token that has the same token value as the one entered by the user
      //If the token is found, then set physicianUid to the physicianUid of that token
      //else show snackbar that the token is invalid and return
      bool isTokenValid = false;
      for (Token token in allTokens) {
        if (token.token == tokenValue) {
          physicianUid = token.physicianUid;
          //save the physician's details to sharedPref
          sharedPreferencesService.setString(
              keyPhysicianFullName, token.physicianFullName!);
          sharedPreferencesService.setString(
              keyPhysicianEmail, token.physicianEmail!);
          sharedPreferencesService.setString(keyPhysicianUid, physicianUid!);
          log.d('token: ${token.toString()}');
          log.d('physicianUid from vm: $physicianUid');
          isTokenValid = true;
        }
      }
      if (!isTokenValid) {
        snackbarService.showCustomSnackBar(
          message: 'Invalid token, please check and try again',
          variant: SnackbarType.failure,
        );
        return;
      }
    }

    setBusy(true);
    String uid = sharedPreferencesService.getString(keyUid)!;
    String email = sharedPreferencesService.getString(keyEmail)!;
    String userRole = sharedPreferencesService.getString(keyUserRole)!;

    RemoticsUser user = RemoticsUser(
      uid: uid,
      firstName: firstNameValue,
      lastName: lastNameValue,
      gender: _getGender(),
      dateOfBirth: !isPhysician ? _getDateOfBirth() : '',
      email: email,
      phoneNumber: phoneNumberValue,
      userRole: userRole,
      physicianUid: !isPhysician ? physicianUid ?? '' : '',
    );

    saveUserDetailsToSharedPref(user);
    try {
      isPhysician
          ? await firestoreService.savePhysicianDetailsToFirestore(user: user)
          : await firestoreService.savePatientDetailsToFirestore(user: user);
    } catch (e) {
      log.e(e);
      snackbarService.showCustomSnackBar(
        message: 'Something went wrong, please try again later',
        variant: SnackbarType.failure,
      );
      setBusy(false);
      return;
    }
    setBusy(false);
    snackbarService.showCustomSnackBar(
      message: 'Welcome, $firstNameValue',
      variant: SnackbarType.success,
      duration: const Duration(seconds: 3),
    );
    navigateToNavBarView();
  }
}

void saveUserDetailsToSharedPref(RemoticsUser user) {
  sharedPreferencesService
    ..setString(keyFirstName, user.firstName!)
    ..setString(keyLastName, user.lastName!)
    ..setString(keyGender, user.gender!)
    ..setString(keyDateOfBirth, user.dateOfBirth!)
    ..setString(keyPhoneNumber, user.phoneNumber!);
}
