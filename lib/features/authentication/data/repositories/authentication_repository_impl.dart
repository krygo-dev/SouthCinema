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
  AuthUser? get currentUser => authenticationService.currentUser;

  @override
  Future<Either<BaseError, AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final authUser = await authenticationService.signInWithEmailAndPassword(
            email, password);
        return Right(authUser);
      } on AuthError catch (error) {
        return Left(error);
      }
    } else {
      return const Left(NetworkError());
    }
  }

  @override
  Future<Either<BaseError, AuthUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final authUser = await authenticationService.signUpWithEmailAndPassword(
            email, password);
        return Right(authUser);
      } on AuthError catch (error) {
        return Left(error);
      }
    } else {
      return const Left(NetworkError());
    }
  }

  @override
  Future<void> signOut() async {
    if (await networkInfo.isConnected) {
      return await authenticationService.signOut();
    } else {
      throw const NetworkError();
    }
  }
}
