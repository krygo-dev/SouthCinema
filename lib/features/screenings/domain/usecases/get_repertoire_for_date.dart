import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';
import 'package:south_cinema/features/screenings/domain/repositories/screenings_repository.dart';

class GetRepertoireForDate {
  final ScreeningsRepository repository;

  GetRepertoireForDate(this.repository);

  Future<Either<BaseError, List<RepertoireScreening>>> call({
    required String date,
  }) async {
    return await repository.getRepertoireForDate(date: date);
  }
}
