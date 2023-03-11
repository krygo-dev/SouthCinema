import 'package:cloud_firestore/cloud_firestore.dart';
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
          .collection('repertoire')
          .where('date', isEqualTo: date)
          .get()).docs;

      final repertoireList = snapshots.map((snapshot) => RepertoireScreening.fromJson(snapshot.data())).toList();
      return repertoireList;
    } on FirebaseException catch (e) {
      throw GettingDataError(message: e.message ?? 'Unexpected error');
    }
  }

  @override
  Future<Room> getRoomById(String id) {
    // TODO: implement getRoomById
    throw UnimplementedError();
  }

  @override
  Future<Screening> getScreeningById(String id) {
    // TODO: implement getScreeningById
    throw UnimplementedError();
  }
}
