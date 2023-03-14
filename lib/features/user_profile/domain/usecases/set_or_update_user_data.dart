import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';
import 'package:south_cinema/features/user_profile/domain/repositories/user_profile_repository.dart';

class SetOrUpdateUserData {
  final UserProfileRepository repository;

  SetOrUpdateUserData(this.repository);

  Future<Either<BaseError, bool>> call({required User user}) async {
    return await repository.setOrUpdateUserData(user: user);
  }
}