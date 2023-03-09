import 'package:dartz/dartz.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';
import 'package:south_cinema/core/error/error.dart';

abstract class AuthenticationRepository {
  AuthUser? get currentUser;

  Future<Either<BaseError, AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<BaseError, AuthUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
