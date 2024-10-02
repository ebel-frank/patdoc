import 'package:patdoc/services/firebase_auth_service.dart';
import 'package:patdoc/services/firebase_rtdb_service.dart';
import 'package:patdoc/services/firestore_service.dart';
import 'package:patdoc/services/shared_preferences_service.dart';
import 'package:patdoc/ui/views/appointments/appointments_view.dart';
import 'package:patdoc/ui/views/auth/login/login_view.dart';
import 'package:patdoc/ui/views/auth/onboarding/onboarding_view.dart';
import 'package:patdoc/ui/views/auth/select_role/select_role_view.dart';
import 'package:patdoc/ui/views/auth/sign_up/sign_up_view.dart';
import 'package:patdoc/ui/views/auth/sign_up_details/sign_up_details_view.dart';
import 'package:patdoc/ui/views/auth/splashscreen/splashscreen_view.dart';
import 'package:patdoc/ui/views/home/book_appointment/book_appointment_view.dart';
import 'package:patdoc/ui/views/messages/messages_list/messages_list_view.dart';
import 'package:patdoc/ui/views/messages/messages_view.dart';
import 'package:patdoc/ui/views/nav_bar/nav_bar_view.dart';
import 'package:patdoc/ui/views/patients/patients_view.dart';
import 'package:patdoc/ui/views/token/generate_token_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreenView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: SelectRoleView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: SignUpDetailsView),
    MaterialRoute(page: NavBarView),
    MaterialRoute(page: BookAppointmentView),
    MaterialRoute(page: GenerateTokenView),
    MaterialRoute(page: PatientsView),
    MaterialRoute(page: AppointmentsView),
    MaterialRoute(page: MessagesListView),
    MaterialRoute(page: MessagesView),
  ],
  dependencies: [
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
    Presolve(
      classType: FirebaseAuthService,
      presolveUsing: FirebaseAuthService.getInstance,
    ),
    Presolve(
      classType: FirestoreService,
      presolveUsing: FirestoreService.getInstance,
    ),
    Presolve(
      classType: FirebaseDatabaseService,
      presolveUsing: FirebaseDatabaseService.getInstance,
    ),
    Presolve(
      classType: SharedPreferencesService,
      presolveUsing: SharedPreferences.getInstance,
    ),
  ],
  logger: StackedLogger(),
)
class App {}
