import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/core/network/network_info.dart';
import 'package:south_cinema/features/authentication/data/datasources/authentication_service.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';
import 'package:south_cinema/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationService authenticationService;
  final NetworkInfo networkInfo;


  AuthenticationRepositoryImpl({
    required this.authenticationService,
    required this.networkInfo,
  });

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => throw UnimplementedError();

  @override
  Future<Either<Error, AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final authUser = await authenticationService.signInWithEmailAndPassword(email, password);
        return Right(authUser);
      } on AuthError catch(error) {
        return Left(error);
      }
    } else {
      return Left(NetworkError());
    }
  }

  @override
  Future<Either<Error, AuthUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
