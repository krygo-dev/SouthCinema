import 'package:dartz/dartz.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';
import 'package:south_cinema/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:south_cinema/core/error/error.dart';

class SignUpWithEmailAndPassword {
  final AuthenticationRepository repository;

  SignUpWithEmailAndPassword(this.repository);

  Future<Either<BaseError, AuthUser>> call({
    required String email,
    required String password,
    required String repeatPassword,
  }) async {
    if (password != repeatPassword) return Left(AuthError(message: 'Passwords are different'));
    return await repository.signUpWithEmailAndPassword(email: email, password: password);
  }
}