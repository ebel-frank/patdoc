import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:patdoc/app/app.logger.dart';

class FirebaseDatabaseService {
  final log = getLogger('FirestoreService');

  FirebaseDatabaseService._();

  static final _instance = FirebaseDatabaseService._();

  final FirebaseDatabase _db = FirebaseDatabase.instance;

  static Future<FirebaseDatabaseService> getInstance() =>
      Future.value(_instance);

  ///listen to updates on rtdb Scanned List field
  Stream<Map<Object?, Object?>> listenForScannedListUpdates() {
    final ref = _db.ref().child('glucometer');
    return ref.onValue
        .map((event) => event.snapshot.value as Map<Object?, Object?>);
  }
}
