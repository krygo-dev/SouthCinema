import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';

abstract class UserProfileRepository {
  Future<Either<BaseError, User>> getUserById({required String uid});
  Future<Either<BaseError, bool>> setOrUpdateUserData({required User user});
}