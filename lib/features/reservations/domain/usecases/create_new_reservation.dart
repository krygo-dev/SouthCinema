import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/reservations/domain/repositories/reservations_repository.dart';

class CreateNewReservation {
  final ReservationsRepository repository;

  CreateNewReservation(this.repository);

  Future<Either<BaseError, bool>> call({
    required Reservation reservation,
  }) async {
    if (reservation.fullName.isEmpty ||
        reservation.email.isEmpty ||
        reservation.phoneNumber.isEmpty) {
      return const Left(EmptyTextFieldError(message: 'Fill up your personal details.'));
    }

    return await repository.createNewReservation(reservation: reservation);
  }
}
