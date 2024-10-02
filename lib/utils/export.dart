import 'package:patdoc/app/app.locator.dart';
import 'package:patdoc/services/firebase_auth_service.dart';
import 'package:patdoc/services/firebase_rtdb_service.dart';
import 'package:patdoc/services/firestore_service.dart';
import 'package:patdoc/services/shared_preferences_service.dart';
import 'package:stacked_services/stacked_services.dart';

final dialogService = locator<DialogService>();
final firebaseAuthService = locator<FirebaseAuthService>();
final firestoreService = locator<FirestoreService>();
final firebaseRtdbService = locator<FirebaseDatabaseService>();
final navigationService = locator<NavigationService>();
final sharedPreferencesService = locator<SharedPreferencesService>();
final snackbarService = locator<SnackbarService>();
