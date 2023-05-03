import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:south_cinema/core/util/constants.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/screenings/data/datasources/screenings_service.dart';
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';
import 'package:south_cinema/features/screenings/domain/entities/room.dart';
import 'package:south_cinema/features/screenings/domain/entities/screening.dart';

class ScreeningsServiceImpl implements ScreeningsService {
  final FirebaseFirestore firebaseFirestore;

  ScreeningsServiceImpl(this.firebaseFirestore);

  @override
  Future<List<RepertoireScreening>> getRepertoireForDate(String date) async {
    try {
      final snapshots = (await firebaseFirestore
              .collection(repertoirePath)
              .where('date', isEqualTo: date)
              .get()).docs;

      final repertoireList = snapshots
          .map((snapshot) => RepertoireScreening.fromJson(snapshot.data()))
          .toList();
      return repertoireList;
    } on FirebaseException catch (e) {
      throw GettingDataError(message: e.message ?? 'Unexpected error');
    }
  }

  @override
  Future<Room> getRoomById(String id) async {
    try {
      final doc = await firebaseFirestore.collection(roomsPath).doc(id).get();
      return Room.fromJson(doc.data()!);
    } on FirebaseException catch (e) {
      throw GettingDataError(message: e.message ?? 'Unexpected error');
    }
  }

  @override
  Future<Screening> getScreeningById(String id) async {
    try {
      final doc =
          await firebaseFirestore.collection(screeningsPath).doc(id).get();
      return Screening.fromJson(doc.data()!);
    } on FirebaseException catch (e) {
      throw GettingDataError(message: e.message ?? 'Unexpected error');
    }
  }

  @override
  Future<void> updateScreeningSeatsTaken(String screeningId, List<String> newTakenSeats) async {
    try {
      await firebaseFirestore
          .collection(screeningsPath)
          .doc(screeningId)
          .update({'seatsTaken': FieldValue.arrayUnion(newTakenSeats)});
    } on FirebaseException catch (e) {
      throw SettingDataError(message: e.message ?? 'Unexpected error');
    }
  }
}
