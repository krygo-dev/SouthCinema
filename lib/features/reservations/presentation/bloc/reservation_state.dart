part of 'reservation_bloc.dart';

abstract class ReservationState extends Equatable {
  @override
  List<Object> get props => [];
}

class ReservationEmpty extends ReservationState {}

class ReservationLoading extends ReservationState {}

class ReservationLoaded extends ReservationState {
  final bool reservationSuccessful;

  ReservationLoaded({required this.reservationSuccessful});

  @override
  List<Object> get props => [reservationSuccessful];
}

class ReservationError extends ReservationState {
  final String message;

  ReservationError({required this.message});

  @override
  List<Object> get props => [message];
}
