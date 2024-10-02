import 'package:intl/intl.dart';
import 'package:patdoc/app/app.logger.dart';
import 'package:patdoc/models/appointment.dart';
import 'package:patdoc/ui/views/home/book_appointment/book_appointment_view.form.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/enums.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BookAppointmentViewModel extends FormViewModel {
  final log = getLogger('BookAppointmentViewModel');
  String date = DateFormat.yMMMEd().format(DateTime.now());
  String time = DateFormat('HH:mm', 'en_US').format(DateTime.now());
  String physicianName =
      sharedPreferencesService.getString(keyPhysicianFullName) ?? '';

  void setDate(newDate) {
    log.d('newDate: $newDate');
    date = DateFormat.yMMMEd().format(newDate);
    log.d('date: $date');
    notifyListeners();
  }

  void setTime(newTime) {
    log.d('newTime: $newTime');
    //first, convert TimeOfDay (newTime) to DateTime
    DateTime convertedNewTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      newTime.hour,
      newTime.minute,
    );
    log.d('convertedNewTime: $convertedNewTime');
    time = DateFormat('HH:mm').format(convertedNewTime);
    log.d('time: $time');
    notifyListeners();
  }

  void showAppointmentSuccessDialog() async {
    log.d('showAppointmentSuccessDialog()');
    final DialogResponse? response = await dialogService.showCustomDialog(
      variant: DialogType.appointmentSuccess,
      barrierDismissible: true,
      description: 'Dr. $physicianName',
      data: '$date at $time WAT',
    );
    log.d('response: $response');
    if (response?.confirmed == true) {
      log.d('response confirmed: ${response?.confirmed}');
    }
  }

  Future<void> bookAppointment() async {
    String patientEmail = sharedPreferencesService.getString(keyEmail) ?? '';
    String patientFirstName =
        sharedPreferencesService.getString(keyFirstName) ?? '';
    String patientLastName =
        sharedPreferencesService.getString(keyLastName) ?? '';
    String patientFullName = '$patientFirstName $patientLastName';
    String patientUid = sharedPreferencesService.getString(keyUid) ?? '';
    String physicianUid =
        sharedPreferencesService.getString(keyPhysicianUid) ?? '';

    Appointment appointment = Appointment(
      physicianUid: physicianUid,
      physicianName: physicianName,
      date: date,
      time: time,
      complaints: noteValue ?? '',
      patientUid: patientUid,
      patientName: patientFullName,
      patientEmail: patientEmail,
    );
    setBusy(true);
    final response =
        await firestoreService.createAppointment(appointment: appointment);

    if (response == true) {
      showAppointmentSuccessDialog();
      snackbarService.showCustomSnackBar(
        message: 'Appointment booked successfully.',
        variant: SnackbarType.success,
      );
      setBusy(false);
    } else {
      log.d('Error booking appointment');
      snackbarService.showCustomSnackBar(
        message: 'Error booking appointment. Please try again.',
        variant: SnackbarType.failure,
      );
      setBusy(false);
    }
  }
}
