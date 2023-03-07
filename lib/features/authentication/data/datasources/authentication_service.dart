import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';

abstract class AuthenticationService {
  AuthUser? get currentUser;
  Future<AuthUser> signInWithEmailAndPassword(String email, String password);
  Future<AuthUser> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}