import 'package:patdoc/app/app.logger.dart';
import 'package:patdoc/utils/app_strings.dart';
import 'package:patdoc/utils/db_keys.dart';
import 'package:patdoc/utils/export.dart';
import 'package:stacked/stacked.dart';

class NavBarViewModel extends IndexTrackingViewModel {
  final log = getLogger('NavBarViewModel');
  bool isPhysician = false;

  void init() {
    isPhysician = sharedPreferencesService.getString(keyUserRole) == physician;
    notifyListeners();
  }

  int _currentIndex = 0;
  bool _reverse = false;

  @override
  int get currentIndex => _currentIndex;

  /// Indicates whether we're going forward or backward in terms of the index we're changing.
  /// This is very helpful for the page transition directions.
  @override
  bool get reverse => _reverse;

  @override
  void setIndex(int value) {
    if (value < _currentIndex) {
      _reverse = true;
    } else {
      _reverse = false;
    }
    _currentIndex = value;
    notifyListeners();
  }

  @override
  bool isIndexSelected(int index) => _currentIndex == index;
}
