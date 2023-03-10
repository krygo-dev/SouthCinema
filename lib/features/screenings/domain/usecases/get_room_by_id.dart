import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/screenings/domain/entities/room.dart';
import 'package:south_cinema/features/screenings/domain/repositories/screenings_repository.dart';

class GetRoomById {
  final ScreenignsRepository repository;

  GetRoomById(this.repository);

  Future<Either<BaseError, Room>> call({required String id}) async {
    return await repository.getRoomById(id: id);
  }
}
