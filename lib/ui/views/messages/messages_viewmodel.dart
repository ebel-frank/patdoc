import 'package:intl/intl.dart';
import 'package:patdoc/app/app.logger.dart';
import 'package:patdoc/app/app.router.dart';
import 'package:patdoc/models/message.dart';
import 'package:patdoc/ui/views/messages/messages_view.form.dart';
import 'package:patdoc/utils/app_strings.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class MessagesViewModel extends FormViewModel {
  final log = getLogger('MessagesViewModel');

  String physicianUid = sharedPreferencesService.getString(keyPhysicianUid)!;
  String patientUid = sharedPreferencesService.getString(keyUid)!;
  String patientFullName = sharedPreferencesService
          .getString(keyCurrentUserChatId) ??
      '${sharedPreferencesService.getString(keyFirstName)} ${sharedPreferencesService.getString(keyLastName)}';
  String? userChatId = sharedPreferencesService.getString(keyCurrentUserChatId);
  bool isPhysician =
      sharedPreferencesService.getString(keyUserRole) == physician;
  String currentUserRole = sharedPreferencesService.getString(keyUserRole)!;
  List<Message> messagesList = [];

  Future<void> init() async {
    log.d('User is a patient: $isPhysician');
    if (isPhysician) {
      physicianUid = patientUid;
    }

    /// use the Stream of Message from firestoreService.listenToMessages() to update the UI
    log.d('physicianId : $physicianUid');
    log.d('userId: $patientUid');
    Stream<List<Message>> messages = firestoreService.listenToMessages(
      physicianUid: physicianUid,
      patientUid: patientUid,
      patientFullName: patientFullName,
    );
    messages.listen((event) {
      log.d('Messages: ${event.first.message}');
      messagesList = event;
      notifyListeners();
    });
  }

  Future<void> sendMessage() async {
    log.d('Sending message: $messageValue');
    await firestoreService.addMessageToFirestore(
      physicianUid: physicianUid,
      patientUid: patientUid,
      message: messageValue!,
      patientName: patientFullName,
      sender: isPhysician ? physician : patient,
    );
    messageValue = '';
    notifyListeners();
  }

  Future<void> signOut() async {
    await firebaseAuthService.signOut();
    await sharedPreferencesService.clearStorage();
    sharedPreferencesService.setBool(keyIsUserOnboarded, true);
    navigationService.clearStackAndShow(Routes.loginView);
  }

  String date = DateFormat.yMMMEd().format(DateTime.now());
  String time = DateFormat('HH:mm', 'en_US').format(DateTime.now());

  ///converts time from millisecondsSinceEpoch to DD-MM-YY HH:MM
  String convertDate(int timestamp) {
    log.d('newDate: $timestamp');
    date = DateFormat.MMMEd()
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
    time = DateFormat('HH:mm', 'en_US')
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
    log.d('date: $date');
    log.d('time: $time');
    return '$time $date';
  }
}
