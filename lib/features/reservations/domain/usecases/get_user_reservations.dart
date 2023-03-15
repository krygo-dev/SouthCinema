import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/reservations/domain/repositories/reservations_repository.dart';

class GetUserReservations {
  final ReservationsRepository repository;

  GetUserReservations(this.repository);

  Future<Either<BaseError, List<Reservation>>> call({required String uid}) async {
    return await repository.getUserReservations(uid: uid);
  }
}