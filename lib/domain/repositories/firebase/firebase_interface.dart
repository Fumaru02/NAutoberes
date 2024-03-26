import '../../models/users_model.dart';

abstract class IFirebaseRepository {
  Future<dynamic> signInWithEmailPassword(
    String email,
    String password,
  );
  Future<dynamic> signUpWithEmailAndPassword(
    String email,
    String password,
    bool agreeTerms,
  );
  Future<dynamic> forgotPassword(String email);
  Future<bool> isUserAgreeTerms();
  Future<UsersModel?> signInWithGoogle();
}
