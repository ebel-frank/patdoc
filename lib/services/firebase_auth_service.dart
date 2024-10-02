import 'package:firebase_auth/firebase_auth.dart';
import 'package:patdoc/app/app.logger.dart';

class FirebaseAuthService {
  final log = getLogger('FirebaseAuthService');

  FirebaseAuthService._();

  static final FirebaseAuthService _instance = FirebaseAuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<FirebaseAuthService> getInstance() => Future.value(_instance);

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential?>? signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log.wtf('Result: $response');

      return response;
    } catch (e) {
      log.wtf('Result: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }

  
}
