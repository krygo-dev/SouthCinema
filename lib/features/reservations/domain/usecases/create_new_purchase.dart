import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/reservations/domain/repositories/reservations_repository.dart';

class CreateNewPurchase {
  final ReservationsRepository repository;

  CreateNewPurchase(this.repository);

  Future<Either<BaseError, bool>> call({
    required Purchase purchase,
  }) async {
    if (purchase.fullName.isEmpty ||
        purchase.email.isEmpty ||
        purchase.phoneNumber.isEmpty) {
      return const Left(EmptyTextFieldError());
    }

    return await repository.createNewPurchase(purchase: purchase);
  }
}
