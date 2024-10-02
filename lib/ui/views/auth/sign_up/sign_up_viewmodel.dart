import 'package:patdoc/app/app.logger.dart';
import 'package:patdoc/app/app.router.dart';
import 'package:patdoc/ui/views/auth/sign_up/sign_up_view.form.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/enums.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends FormViewModel {
  final log = getLogger('SignUpViewModel');
  bool obscureText = true;

  void togglePasswordVisibility() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void navigateToSignUpDetails() {
    navigationService.navigateTo(Routes.signUpDetailsView);
  }

  void navigateToSignIn() => navigationService.navigateToLoginView();

  Future<void> signUp() async {
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
      log.d('Signing up with email: $emailValue, password: $passwordValue');
      final result = await firebaseAuthService.createUserWithEmailAndPassword(
        email: emailValue!,
        password: passwordValue!,
      );
      log.d('Result: $result');
      if (result.user?.email == emailValue) {
        sharedPreferencesService.setString(keyUid, result.user!.uid);
        sharedPreferencesService.setString(keyEmail, emailValue!);

        snackbarService.showCustomSnackBar(
          message: 'Sign up successful',
          variant: SnackbarType.success,
        );
        navigateToSignUpDetails();
      } else {
        snackbarService.showCustomSnackBar(
          message: 'Sign up failed',
          variant: SnackbarType.failure,
        );
      }
    } catch (e) {
      log.e(e);
      snackbarService.showCustomSnackBar(
        message: e.toString().replaceRange(0, 14, '').split(']')[1],
        variant: SnackbarType.failure,
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }
}
