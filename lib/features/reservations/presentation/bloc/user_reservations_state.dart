part of 'user_reservations_bloc.dart';

abstract class UserReservationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserReservationsEmpty extends UserReservationsState {}

class UserReservationsLoading extends UserReservationsState {}

class UserReservationsLoaded extends UserReservationsState {
  final List<Reservation> reservationsList;

  UserReservationsLoaded({required this.reservationsList});

  @override
  List<Object> get props => [reservationsList];
}

class UserReservationsError extends UserReservationsState {
  final String message;

  UserReservationsError({required this.message});

  @override
  List<Object> get props => [message];
}
