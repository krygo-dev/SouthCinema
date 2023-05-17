import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/reservations/domain/usecases/get_user_reservations.dart';

part 'user_reservations_event.dart';

part 'user_reservations_state.dart';

class UserReservationsBloc
    extends Bloc<UserReservationsEvent, UserReservationsState> {
  final GetUserReservations getUserReservation;

  UserReservationsBloc({required this.getUserReservation})
      : super(UserReservationsEmpty()) {
    on<GetUserReservationsEvent>(_getUserReservations);
  }

  FutureOr<void> _getUserReservations(
    GetUserReservationsEvent event,
    Emitter<UserReservationsState> emit,
  ) async {
    emit(UserReservationsLoading());
    final errorOrResList = await getUserReservation(uid: event.uid);
    errorOrResList.fold(
      (error) => emit(UserReservationsError(message: error.message)),
      (resList) => emit(UserReservationsLoaded(reservationsList: resList)),
    );
  }
}
