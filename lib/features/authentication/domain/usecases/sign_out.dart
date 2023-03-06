import 'package:south_cinema/features/authentication/domain/repositories/authentication_repository.dart';

class SignOut {
  final AuthenticationRepository repository;

  SignOut(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}