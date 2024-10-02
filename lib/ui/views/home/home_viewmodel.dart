import 'package:patdoc/app/app.logger.dart';
import 'package:patdoc/app/app.router.dart';
import 'package:patdoc/utils/app_strings.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/enums.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewModel extends IndexTrackingViewModel {
  final log = getLogger('HomeViewModel');
  String? firstName;
  Map<Object?, Object?>? oldData = {};
  bool isPhysician = false;

  void init() async {
    firstName = sharedPreferencesService.getString(keyFirstName) ?? 'User';
    isPhysician = sharedPreferencesService.getString(keyUserRole) == physician;
  }

  void navigateToBookAppointmentView() {
    navigationService.navigateTo(Routes.bookAppointmentView);
  }

  void navigateToAppointmentsView() {
    navigationService.navigateTo(Routes.appointmentsView);
  }

  Future<void> openDialer() async {
    Uri phoneNumber = Uri.parse('tel:911');
    if (await canLaunchUrl(phoneNumber)) {
      await launchUrl(phoneNumber);
    } else {
      log.e('Could not launch $phoneNumber');
      snackbarService.showCustomSnackBar(
        message: 'Sorry, could not dial 911',
        variant: SnackbarType.failure,
      );
    }
  }

  void navigateToPatientsView() {
    navigationService.navigateTo(Routes.patientsView);
  }
}
