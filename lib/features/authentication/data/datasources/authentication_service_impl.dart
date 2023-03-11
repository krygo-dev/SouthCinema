import 'package:firebase_auth/firebase_auth.dart';
import 'package:south_cinema/core/error/error.dart';
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
  Future<AuthUser> signInWithEmailAndPassword(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return currentUser!;
    } on FirebaseAuthException catch(e) {
      throw AuthError(message: e.message ?? 'Unexpected error');
    }
  }

  @override
  Future<AuthUser> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return currentUser!;
    } on FirebaseAuthException catch(e) {
      throw AuthError(message: e.message ?? 'Unexpected error');
    }
  }

  @override
  Future<void> signOut() async {
    if (currentUser != null) {
      return await firebaseAuth.signOut();
    } else {
      throw const AuthError(message: 'There is not any logged in user');
    }
  }
}