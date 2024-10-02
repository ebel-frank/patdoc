// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_services/src/snackbar/snackbar_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/firebase_auth_service.dart';
import '../services/firebase_rtdb_service.dart';
import '../services/firestore_service.dart';
import '../services/shared_preferences_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackbarService());
  final firebaseAuthService = await FirebaseAuthService.getInstance();
  locator.registerSingleton(firebaseAuthService);

  final firestoreService = await FirestoreService.getInstance();
  locator.registerSingleton(firestoreService);

  final firebaseDatabaseService = await FirebaseDatabaseService.getInstance();
  locator.registerSingleton(firebaseDatabaseService);

  final sharedPreferencesService = await SharedPreferencesService.getInstance();
  locator.registerSingleton(sharedPreferencesService);
}
