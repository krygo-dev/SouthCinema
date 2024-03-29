import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';
import 'package:south_cinema/features/user_profile/domain/repositories/user_profile_repository.dart';

class GetUserById {
  final UserProfileRepository repository;

  GetUserById(this.repository);

  Future<Either<BaseError, User>> call({required String uid}) async {
    return await repository.getUserById(uid: uid);
  }
}