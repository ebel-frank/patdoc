import 'package:patdoc/app/app.logger.dart';
import 'package:patdoc/utils/app_strings.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class AppointmentsViewModel extends IndexTrackingViewModel {
  final log = getLogger('AppointmentsViewModel');

  final String uid = sharedPreferencesService.getString(keyUid) ?? '';
  bool isPhysician =
      sharedPreferencesService.getString(keyUserRole) == physician;
}
