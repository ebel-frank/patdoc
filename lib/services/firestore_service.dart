import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patdoc/app/app.logger.dart';
import 'package:patdoc/models/appointment.dart';
import 'package:patdoc/models/message.dart';
import 'package:patdoc/models/remotics_user.dart';
import 'package:patdoc/models/token.dart';

class FirestoreService {
  final log = getLogger('FirestoreService');

  FirestoreService._();

  static final _instance = FirestoreService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<FirestoreService> getInstance() => Future.value(_instance);

  Future<void> savePhysicianDetailsToFirestore({
    required RemoticsUser user,
  }) async {
    await _db.collection('${user.userRole}s').doc(user.uid).set(
      {
        'uid': user.uid,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'gender': user.gender,
        'dateOfBirth': user.dateOfBirth,
        'phoneNumber': user.phoneNumber,
        'email': user.email,
        'userRole': user.userRole,
      },
    );
    await _saveUserDetailsToFirestore(user: user);
  }

  //save user details under the patient collection under the physician's uid document
  Future<void> savePatientDetailsToFirestore({
    required RemoticsUser user,
  }) async {
    log.d('Saving patient details to firestore');
    log.d('Patient uid: ${user.uid}');
    log.d('Physician uid: ${user.physicianUid}');

    await _db
        .collection('physicians')
        .doc(user.physicianUid)
        .collection('patients')
        .doc(user.uid)
        .set(user.toJson());
    log.wtf(
        'Patient details saved to firestore under physician uid ${user.toJson()}, patient uid ${user.physicianUid}');
    await _saveUserDetailsToFirestore(user: user);
  }

  //save all users details to firestore (root/usersInfo/remoticsUsers) for easy access
  Future<void> _saveUserDetailsToFirestore({
    required RemoticsUser user,
  }) async {
    await _db
        .collection('usersInfo')
        .doc('remoticsUsers')
        .collection('${user.userRole}s')
        .doc(user.uid)
        .set(user.toJson());
  }

  ///gets user details from firestore using user uid
  Future<RemoticsUser> getUserProfileFromFirestore(
      {required String uid}) async {
    //loop through the physicians, patients and caregivers collections to find the user
    List<String> collections = ['physicians', 'patients', 'caregivers'];
    for (String collection in collections) {
      final userDoc = await _db
          .collection('usersInfo')
          .doc('remoticsUsers')
          .collection(collection)
          .doc(uid)
          .get();
      if (userDoc.exists) {
        log.d('User profile found, ${userDoc.data()}}');
        return RemoticsUser.fromJson(userDoc.data()!);
      }
    }
    throw Exception('User profile not found');
  }

  ///adds an appointment to the appointments collection under the physician's uid
  Future<bool> createAppointment({required Appointment appointment}) async {
    try {
      await _db
          .collection('physicians')
          .doc(appointment.physicianUid)
          .collection('appointments')
          .add(appointment.toJson());
      log.d('Appointment created successfully');
      return true;
    } catch (error) {
      log.d('Error creating appointment: $error');
      return false;
    }
  }

  ///gets all appointments from the appointments collection under the physician's uid
  ///returns a list of appointments
  ///if no appointments are found, returns an empty list
  ///if an error occurs, returns an empty list
  Future<List<Appointment>> getAllAppointmentsFromFirestore(
      {required String physicianUid}) async {
    List<Appointment> allAppointments = [];
    try {
      final appointments = await _db
          .collection('physicians')
          .doc(physicianUid)
          .collection('appointments')
          .get();
      allAppointments =
          appointments.docs.map((e) => Appointment.fromJson(e.data())).toList();
      log.d(
          'Appointments retrieval successful. Appointments: ${allAppointments.first.patientUid}, ${allAppointments.length}}');
      return allAppointments;
    } catch (error) {
      log.d('Failed to retrieve appointments error: $error');
      return [];
    }
  }

  ///listen to updates on firestore appointments collection under the physician's uid
  Stream<List<Appointment>> listenToAppointments(
      {required String physicianUid}) {
    Stream<List<Appointment>> appointments = _db
        .collection('physicians')
        .doc(physicianUid)
        .collection('appointments')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Appointment.fromJson(document.data()))
            .toList());
    log.d('Listening to appointments, ${appointments.toString()}');
    return appointments;
  }

  ///listen to updates on the patients collection under physicians>physicianUid>patients
  Stream<List<RemoticsUser>> listenToPhysicianPatients(
      {required String physicianUid}) {
    Stream<List<RemoticsUser>> patients = _db
        .collection('physicians')
        .doc(physicianUid)
        .collection('patients')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((document) => RemoticsUser.fromJson(document.data()))
              .toList(),
        );
    log.d('Listening to physician patients, ${patients.length}');
    return patients;
  }

  ///Chat Section
  ///adds a message to the physician's uid collection under the messages collection
  ///returns true if successful, false if not
  ///if an error occurs, returns false
  ///if the message is empty, returns false
  ///if the message is null, returns false
  ///if the message is not empty, returns true
  Future<bool> addMessageToFirestore(
      {required String physicianUid,
      required String patientUid,
      required String sender,
      required String patientName,
      required String message}) async {
    try {
      log.d('Adding message to firestore');
      log.d('Message: $message');
      log.d('Sender: $sender');
      log.d('PhysicianUid: $physicianUid');
      log.d('PatientUid: $patientUid');
      await _db
          .collection('messages')
          .doc(physicianUid)
          .collection(patientName)
          .add({
        'message': message,
        'sender': sender,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      log.d('Message added successfully');
      log.d('Message: $message');
      log.d('Sender: $patientUid');
      log.d('Physician: $physicianUid');
      log.d('Timestamp: ${DateTime.now().millisecondsSinceEpoch}');

      return true;
    } catch (error) {
      log.d('Error adding message: $error');
      return false;
    }
  }

  ///Fetch the list of users under the physician in physicians>uid>patients collection
  ///returns a list of patients
  ///if an error occurs, returns an empty list
  ///if no patients are found, returns an empty list
  Future<List<RemoticsUser>> getAllPhysicianPatientsFromFirestore(
      {required String physicianUid}) async {
    List<RemoticsUser> allPatients = [];
    try {
      final patients = await _db
          .collection('physicians')
          .doc(physicianUid)
          .collection('patients')
          .get();
      allPatients =
          patients.docs.map((e) => RemoticsUser.fromJson(e.data())).toList();
      log.d(
          'Patients retrieval successful. Patients: ${allPatients.first.firstName}, ${allPatients.length}}');
      return allPatients;
    } catch (error) {
      log.d('Failed to retrieve patients error: $error');
      return [];
    }
  }

  ///listens to the updates on messages>physicianUid>patientUid collection
  ///returns a stream of messages
  ///if an error occurs, returns an empty list
  ///if no messages are found, returns an empty list
  ///if messages are found, returns a list of messages
  Stream<List<Message>> listenToMessages(
      {required String physicianUid,
      required String patientUid,
      required String patientFullName}) {
    log.d('Listening to messages');
    log.d('PhysicianUid: $physicianUid');
    log.d('PatientUid: $patientUid');
    log.d('PatientFullName: $patientFullName');
    Stream<List<Message>> messages = _db
        .collection('messages')
        .doc(physicianUid)
        .collection(patientFullName)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Message.fromJson(document.data()))
            .toList());
    log.d('Listening to messages, ${messages.toString()}');
    return messages;
  }

  ///get all patients from the patients collection under the physician's uid
  ///returns a list of patients
  ///if no patients are found, returns an empty list
  ///if an error occurs, returns an empty list
  Future<List<RemoticsUser>> getAllPatientsFromFirestore(
      {required String physicianUid}) async {
    List<RemoticsUser> allPatients = [];
    try {
      log.d('Retrieving patients from firestore: $physicianUid');
      final patients = await _db
          .collection('physicians')
          .doc(physicianUid)
          .collection('patients')
          .get();
      allPatients =
          patients.docs.map((e) => RemoticsUser.fromJson(e.data())).toList();
      log.d(
          'Patients retrieval successful. Patients: ${allPatients.first.firstName}, ${allPatients.length}}');
      return allPatients;
    } catch (error) {
      log.d('Failed to retrieve patients error: $error');
      return [];
    }
  }

  Future<bool> saveTokenToFirebase({required Token token}) async {
    try {
      await _db.collection('tokens').doc(token.token).set(token.toJson());
      log.d('Firebase operation successful');
      return true;
    } catch (error) {
      log.d('Firebase operation failed with error: $error');
      return false;
    }
  }

  Future<List<Token>> getAllTokensFromFirestore() async {
    List<Token> allTokens = [];
    try {
      final tokens = await _db.collection('tokens').get();
      allTokens = tokens.docs.map((e) => Token.fromJson(e.data())).toList();
      log.d(
          'Tokens retrieval successful. Tokens: ${allTokens.first.token}, ${allTokens.length}}');
      return allTokens;
    } catch (error) {
      log.d('Failed to retrieve tokens error: $error');
      return [];
    }
  }
}
