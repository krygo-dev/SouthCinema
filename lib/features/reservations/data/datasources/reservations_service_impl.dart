import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:south_cinema/core/util/constants.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/data/datasources/reservations_service.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/screenings/data/datasources/screenings_service.dart';

class ReservationsServiceImpl implements ReservationService {
  final FirebaseFirestore firebaseFirestore;
  final ScreeningsService screeningsService;

  ReservationsServiceImpl(this.firebaseFirestore, this.screeningsService);

  @override
  Future<bool> createNewReservation(Reservation reservation) async {
    try {
      final collectionRef = firebaseFirestore.collection(reservationsPath);
      final documentId =
          await collectionRef.add(reservation.toJson()).then((doc) => doc.id);

      await collectionRef.doc(documentId).update({'id': documentId});
      await screeningsService.updateScreeningSeatsTaken(
        reservation.screeningId,
        reservation.seats,
      );

      return true;
    } on FirebaseException catch (e) {
      throw SettingDataError(message: e.message ?? 'Unexpected error');
    }
  }

  @override
  Future<List<Reservation>> getUserReservations(String uid) async {
    try {
      final snapshots = (await firebaseFirestore
              .collection(reservationsPath)
              .where('userId', isEqualTo: uid)
              .get())
          .docs;

      final reservationsList = snapshots
          .map((snapshot) => Reservation.fromJson(snapshot.data()))
          .toList();
      return reservationsList;
    } on FirebaseException catch (e) {
      throw GettingDataError(message: e.message ?? 'Unexpected error');
    }
  }
}
