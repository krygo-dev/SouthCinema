import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:south_cinema/core/util/constants.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/user_profile/data/datasources/user_service.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';

class UserServiceImpl implements UserService {
  final FirebaseFirestore firebaseFirestore;

  UserServiceImpl(this.firebaseFirestore);

  @override
  Future<User> getUserById(String uid) async {
    try {
      final snapshot = await firebaseFirestore.collection(usersPath).doc(uid).get();
      return User.fromJson(snapshot.data()!);
    } on FirebaseException catch (e) {
      throw GettingDataError(message: e.message ?? 'Unexpected error');
    }
  }

  @override
  Future<bool> setOrUpdateUserData(User user) async {
    try {
      await firebaseFirestore.collection(usersPath).doc(user.uid).set(user.toJson());
      return true;
    } on FirebaseException catch (e) {
      throw SettingDataError(message: e.message ?? 'Unexpected error');
    }
  }
}