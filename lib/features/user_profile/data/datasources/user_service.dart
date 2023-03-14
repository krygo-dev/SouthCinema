import 'package:south_cinema/features/user_profile/domain/entities/user.dart';

abstract class UserService {
  Future<User> getUserById(String uid);
  Future<bool> setOrUpdateUserData(User user);
}