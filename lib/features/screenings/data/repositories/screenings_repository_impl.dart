import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/core/network/network_info.dart';
import 'package:south_cinema/features/screenings/data/datasources/screenings_service.dart';
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';
import 'package:south_cinema/features/screenings/domain/entities/room.dart';
import 'package:south_cinema/features/screenings/domain/entities/screening.dart';
import 'package:south_cinema/features/screenings/domain/repositories/screenings_repository.dart';

class ScreeningsRepositoryImpl implements ScreeningsRepository {
  final ScreeningsService screeningsService;
  final NetworkInfo networkInfo;

  ScreeningsRepositoryImpl({
    required this.screeningsService,
    required this.networkInfo,
  });

  @override
  Future<Either<BaseError, List<RepertoireScreening>>> getRepertoireForDate({
    required String date,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final list = await screeningsService.getRepertoireForDate(date);
        return Right(list);
      } on BaseError catch (e) {
        return Left(e);
      }
    } else {
      return const Left(NetworkError());
    }
  }

  @override
  Future<Either<BaseError, Room>> getRoomById({required String id}) async {
    if (await networkInfo.isConnected) {
      try {
        final room = await screeningsService.getRoomById(id);
        return Right(room);
      } on BaseError catch (e) {
        return Left(e);
      }
    } else {
      return const Left(NetworkError());
    }
  }

  @override
  Future<Either<BaseError, Screening>> getScreeningById({required String id}) async {
    if (await networkInfo.isConnected) {
      try {
        final screening = await screeningsService.getScreeningById(id);
        return Right(screening);
      } on BaseError catch (e) {
        return Left(e);
      }
    } else {
      return const Left(NetworkError());
    }
  }
}
