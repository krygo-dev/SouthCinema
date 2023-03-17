import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/screenings/domain/entities/screening.dart';
import 'package:south_cinema/features/screenings/domain/repositories/screenings_repository.dart';

class GetScreeningById {
  final ScreeningsRepository repository;

  GetScreeningById(this.repository);

  Future<Either<BaseError, Screening>> call({required String id}) async {
    return await repository.getScreeningById(id: id);
  }
}