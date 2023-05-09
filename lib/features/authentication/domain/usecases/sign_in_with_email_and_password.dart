import 'package:dartz/dartz.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';
import 'package:south_cinema/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:south_cinema/core/error/error.dart';

class SignInWithEmailAndPassword {
  final AuthenticationRepository repository;

  SignInWithEmailAndPassword(this.repository);

  Future<Either<BaseError, AuthUser>> call({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return const Left(
        AuthError(message: 'Email and password fields can\'t be empty.'),
      );
    }
    return await repository.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
