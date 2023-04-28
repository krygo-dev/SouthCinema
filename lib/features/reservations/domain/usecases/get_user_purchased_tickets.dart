import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/reservations/domain/repositories/reservations_repository.dart';

class GetUserPurchasedTickets {
  final ReservationsRepository repository;

  GetUserPurchasedTickets(this.repository);

  Future<Either<BaseError, List<Purchase>>> call({required String uid}) async {
    return repository.getUserPurchasedTickets(uid: uid);
  }
}