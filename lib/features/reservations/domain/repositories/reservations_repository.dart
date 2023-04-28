import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';

abstract class ReservationsRepository {
  Future<Either<BaseError, bool>> createNewReservation({
    required Reservation reservation,
  });

  Future<Either<BaseError, List<Reservation>>> getUserReservations({
    required String uid,
  });

  Future<Either<BaseError, bool>> createNewPurchase({
    required Purchase purchase,
  });

  Future<Either<BaseError, List<Purchase>>> getUserPurchasedTickets({
    required String uid,
  });
}
