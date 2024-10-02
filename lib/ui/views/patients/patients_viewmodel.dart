import 'package:patdoc/app/app.logger.dart';
import 'package:patdoc/models/remotics_user.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class PatientsViewModel extends BaseViewModel {
  final log = getLogger('PatientsViewModel');
  List<RemoticsUser> patients = [];
  final String physicianUid = sharedPreferencesService.getString(keyUid) ?? '';

  Future<void> init() async {
    setBusy(true);
    Future<List<RemoticsUser>> response = firestoreService
        .getAllPatientsFromFirestore(physicianUid: physicianUid);
    response.then((value) {
      log.d('Patients: $value');
      patients = value;
      notifyListeners();
    });
    notifyListeners();
    setBusy(false);
  }
}
