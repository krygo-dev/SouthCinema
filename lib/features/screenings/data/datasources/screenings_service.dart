import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';
import 'package:south_cinema/features/screenings/domain/entities/room.dart';
import 'package:south_cinema/features/screenings/domain/entities/screening.dart';

abstract class ScreeningsService {
  Future<List<RepertoireScreening>> getRepertoireForDate(String date);
  Future<Room> getRoomById(String id);
  Future<Screening> getScreeningById(String id);
  Future<void> updateScreeningSeatsTaken(String screeningId, List<String> newTakenSeats);
}