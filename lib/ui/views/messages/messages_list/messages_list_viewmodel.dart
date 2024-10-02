import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class MessagesListViewModel extends BaseViewModel {
  // List<String> patientNames = [];
  String physicianUid = sharedPreferencesService.getString(keyUid)!;

  Future<void> init() async {
    // List<RemoticsUser> patients = await firestoreService
    //     .getAllPhysicianPatientsFromFirestore(physicianUid: physicianUid);
    //
    // for (RemoticsUser patient in patients) {
    //   patientNames.add('${patient.firstName} ${patient.lastName}');
    // }
    // notifyListeners();
  }
}
