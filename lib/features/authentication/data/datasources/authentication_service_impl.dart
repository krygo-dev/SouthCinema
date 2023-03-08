import 'package:firebase_auth/firebase_auth.dart';
import 'package:south_cinema/features/authentication/data/datasources/authentication_service.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';

class AuthenticationServiceImpl implements AuthenticationService {
  final FirebaseAuth firebaseAuth;

  AuthenticationServiceImpl(this.firebaseAuth);

  @override
  AuthUser? get currentUser {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      return AuthUser.fromFirebaseUser(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> signUpWithEmailAndPassword(String email, String password) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}