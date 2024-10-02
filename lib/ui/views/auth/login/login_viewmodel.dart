import 'package:patdoc/app/app.logger.dart';
import 'package:patdoc/app/app.router.dart';
import 'package:patdoc/models/remotics_user.dart';
import 'package:patdoc/ui/views/auth/sign_up/sign_up_view.form.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/enums.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends FormViewModel {
  final log = getLogger('LoginViewModel');
  bool obscureText = true;
  bool rememberMe = false;

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    obscureText = !obscureText;
    notifyListeners();
  }

  // void navigateToForgotPassword() =>
  //     navigationService.navigateToForgotPasswordView();

  void navigateToSignUp() => navigationService.navigateToSignUpView();

  void navigateToSelectRole() => navigationService.navigateToSelectRoleView();

  Future<void> login() async {
    if (emailValue == '' ||
        passwordValue == '' ||
        emailValue == null ||
        passwordValue == null) {
      snackbarService.showCustomSnackBar(
        message: 'Please fill in all fields',
        variant: SnackbarType.failure,
      );
      return;
    }

    try {
      setBusy(true);
      await sharedPreferencesService.clearStorage();
      log.d('Logging in with email: $emailValue, password: $passwordValue');
      final result = await firebaseAuthService.signInWithEmailAndPassword(
        email: emailValue!,
        password: passwordValue!,
      );
      log.d('Result: $result');
      if (result?.user?.email == emailValue) {
        //query firestore for user details
        RemoticsUser currentUser = await firestoreService
            .getUserProfileFromFirestore(uid: result!.user!.uid);

        await saveUserDetailsToSharedPref(currentUser);

        snackbarService.showCustomSnackBar(
          message: 'Welcome back, ${result.user?.email ?? 'to Remotics'}',
          variant: SnackbarType.success,
          duration: const Duration(seconds: 3),
        );
        setBusy(false);
        //? user is logged in
        await sharedPreferencesService.setBool(keyIsLoggedIn, true);
        navigationService.clearStackAndShow(Routes.navBarView);
      }
      if (result == null) {
        snackbarService.showCustomSnackBar(
          message: 'Invalid email or password',
          variant: SnackbarType.failure,
          duration: const Duration(seconds: 3),
        );
      }
      setBusy(false);
    } catch (e) {
      setBusy(false);
      snackbarService.showCustomSnackBar(
        message: e.toString(),
        variant: SnackbarType.failure,
        duration: const Duration(seconds: 5),
      );
      log.wtf('Error logging in: ${e.toString()}');
      log.wtf('Error logging in: $emailValue');
    }
  }

  Future<void> saveUserDetailsToSharedPref(RemoticsUser currentUser) async {
    await sharedPreferencesService.setString(
        keyFirstName, currentUser.firstName!);
    await sharedPreferencesService.setString(
        keyLastName, currentUser.lastName!);
    await sharedPreferencesService.setString(keyEmail, currentUser.email!);
    await sharedPreferencesService.setString(
        keyPhoneNumber, currentUser.phoneNumber!);
    await sharedPreferencesService.setString(
        keyDateOfBirth, currentUser.dateOfBirth!);
    await sharedPreferencesService.setString(keyGender, currentUser.gender!);
    await sharedPreferencesService.setString(
        keyUserRole, currentUser.userRole!);
    await sharedPreferencesService.setString(keyUid, currentUser.uid!);
    await sharedPreferencesService.setString(
        keyPhysicianUid, currentUser.physicianUid!);
    //! FIXME : add to the userModel, retrieve and save value with info from token
    // await sharedPreferencesService.setString(keyPhysicianFullName, currentUser.physicianFullName!);
  }

  @override
  void setFormStatus() {}
}
