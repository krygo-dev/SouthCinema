import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/core/network/network_info.dart';
import 'package:south_cinema/features/user_profile/data/datasources/user_service.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';
import 'package:south_cinema/features/user_profile/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserService userService;
  final NetworkInfo networkInfo;

  UserProfileRepositoryImpl({
    required this.userService,
    required this.networkInfo,
  });

  @override
  Future<Either<BaseError, User>> getUserById({required String uid}) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await userService.getUserById(uid);
        return Right(user);
      } on BaseError catch (e) {
        return Left(e);
      }
    } else {
      return const Left(NetworkError());
    }
  }

  @override
  Future<Either<BaseError, bool>> setOrUpdateUserData({required User user}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await userService.setOrUpdateUserData(user);
        return Right(result);
      } on BaseError catch (e) {
        return Left(e);
      }
    } else {
      return const Left(NetworkError());
    }
  }
}
