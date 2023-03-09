import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';
import 'package:south_cinema/features/screenings/domain/entities/room.dart';
import 'package:south_cinema/features/screenings/domain/entities/screening.dart';

abstract class ScreenignsRepository {
  Future<Either<BaseError, List<RepertoireScreening>>> getRepertoireForDate({required String date});
  Future<Either<BaseError, Screening>> getScreeningById({required String id});
  Future<Either<BaseError, Room>> getRoomById({required String id});
}