import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUser extends Equatable {
  final String uid;
  final String? email;
  final String? displayName;

  const AuthUser({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  factory AuthUser.fromFirebaseUser(User user) {
    return AuthUser(uid: user.uid, email: user.email, displayName: user.displayName);
  }

  @override
  List<Object?> get props => [uid, email, displayName];
}
