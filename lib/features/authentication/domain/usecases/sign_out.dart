import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/authentication/domain/repositories/authentication_repository.dart';

class SignOut {
  final AuthenticationRepository repository;

  SignOut(this.repository);

  Future<Either<BaseError, void>> call() {
    return repository.signOut();
  }
}