import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';

abstract class ReservationService {
  Future<bool> createNewReservation(Reservation reservation);
  Future<List<Reservation>> getUserReservations(String uid);
}