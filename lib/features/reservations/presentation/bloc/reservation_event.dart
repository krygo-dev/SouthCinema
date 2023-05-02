part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateNewReservationEvent extends ReservationEvent {
  final Reservation reservation;

  CreateNewReservationEvent(this.reservation);

  @override
  List<Object> get props => [reservation];
}


class GetUserReservations extends ReservationEvent {
  final String uid;

  GetUserReservations(this.uid);

  @override
  List<Object> get props => [uid];
}
