import 'package:dartz/dartz.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';
import 'package:south_cinema/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:south_cinema/core/error/error.dart';

class SignInWithEmailAndPassword {
  final AuthenticationRepository repository;

  SignInWithEmailAndPassword(this.repository);

  Future<Either<Error, AuthUser>> call({
    required String email,
    required String password,
  }) async {
    return await repository.signInWithEmailAndPassword(email: email, password: password);
  }
}