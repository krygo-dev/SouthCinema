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
    if (email.isEmpty || password.isEmpty || repeatPassword.isEmpty) {
      return const Left(
        AuthError(
            message:
                'Email, password and repeat password fields can\'t be empty.'),
      );
    }
    if (password != repeatPassword) {
      return const Left(AuthError(message: 'Passwords are different'));
    }
    return await repository.signUpWithEmailAndPassword(
        email: email, password: password);
  }
}
