import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';
import 'package:south_cinema/features/authentication/domain/repositories/authentication_repository.dart';

class GetCurrentUser {
  final AuthenticationRepository repository;

  GetCurrentUser(this.repository);

  AuthUser? get call => repository.currentUser;
}