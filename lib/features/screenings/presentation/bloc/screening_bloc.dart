import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:south_cinema/features/screenings/domain/entities/room.dart';
import 'package:south_cinema/features/screenings/domain/entities/screening.dart';

import '../../domain/usecases/get_room_by_id.dart';
import '../../domain/usecases/get_screening_by_id.dart';

part 'screening_event.dart';

part 'screening_state.dart';

class ScreeningBloc extends Bloc<ScreeningEvent, ScreeningState> {
  final GetScreeningById getScreeningById;
  final GetRoomById getRoomById;

  ScreeningBloc({
    required this.getScreeningById,
    required this.getRoomById,
  }) : super(Empty()) {
    on<GetScreeningByIdEvent>(_getScreeningById);
  }

  void _getScreeningById(
    GetScreeningByIdEvent event,
    Emitter<ScreeningState> emit,
  ) async {
    emit(Loading());
    final errorOrScreening = await getScreeningById(id: event.id);
    await errorOrScreening.fold(
      (error) async => emit(Error(message: error.message)),
      (screening) async {
        final errorOrRoom = await getRoomById(id: screening.roomID);
        errorOrRoom.fold(
          (error) => emit(Error(message: error.message)),
          (room) => emit(Loaded(screening: screening, room: room)),
        );
      },
    );
  }
}
