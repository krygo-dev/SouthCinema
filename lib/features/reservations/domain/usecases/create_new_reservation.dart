import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/reservations/domain/repositories/reservations_repository.dart';

class CreateNewReservation {
  final ReservationsRepository repository;

  CreateNewReservation(this.repository);

  Future<Either<BaseError, bool>> call({required Reservation reservation}) async {
    return await repository.createNewReservation(reservation: reservation);
  }
}