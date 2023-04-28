import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/core/network/network_info.dart';
import 'package:south_cinema/features/reservations/data/datasources/purchase_service.dart';
import 'package:south_cinema/features/reservations/data/datasources/reservations_service.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/reservations/domain/repositories/reservations_repository.dart';

class ReservationsRepositoryImpl implements ReservationsRepository {
  final ReservationService reservationService;
  final PurchaseService purchaseService;
  final NetworkInfo networkInfo;

  ReservationsRepositoryImpl({
    required this.reservationService,
    required this.purchaseService,
    required this.networkInfo,
  });

  @override
  Future<Either<BaseError, bool>> createNewReservation({
    required Reservation reservation,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await reservationService.createNewReservation(reservation);
        return Right(result);
      } on BaseError catch (e) {
        return Left(e);
      }
    } else {
      return const Left(NetworkError());
    }
  }

  @override
  Future<Either<BaseError, List<Reservation>>> getUserReservations({
    required String uid,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final reservationsList = await reservationService.getUserReservations(uid);
        return Right(reservationsList);
      } on BaseError catch (e) {
        return Left(e);
      }
    } else {
      return const Left(NetworkError());
    }
  }

  @override
  Future<Either<BaseError, bool>> createNewPurchase({required Purchase purchase}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await purchaseService.createNewPurchase(purchase);
        return Right(result);
      } on BaseError catch (e) {
        return Left(e);
      }
    } else {
      return const Left(NetworkError());
    }
  }

  @override
  Future<Either<BaseError, List<Purchase>>> getUserPurchasedTickets({required String uid}) async {
    if (await networkInfo.isConnected) {
      try {
        final purchasedTicketsList = await purchaseService.getUserPurchasedTickets(uid);
        return Right(purchasedTicketsList);
      } on BaseError catch (e) {
        return Left(e);
      }
    } else {
      return const Left(NetworkError());
    }
  }
}
