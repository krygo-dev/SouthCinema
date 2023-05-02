import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/reservations/domain/usecases/create_new_reservation.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final CreateNewReservation createNewReservation;

  ReservationBloc({required this.createNewReservation}) : super(ReservationEmpty()) {
    on<CreateNewReservationEvent>(_createNewReservation);
  }

  void _createNewReservation(
      CreateNewReservationEvent event,
      Emitter<ReservationState> emit,
      ) async {
    emit(ReservationLoading());
    final errorOrResult = await createNewReservation(reservation: event.reservation);
    errorOrResult.fold(
          (error) => emit(ReservationError(message: error.message)),
          (result) => emit(ReservationLoaded(reservationSuccessful: result)),
    );
  }
}
