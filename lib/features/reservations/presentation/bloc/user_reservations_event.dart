part of 'user_reservations_bloc.dart';

abstract class UserReservationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserReservationsEvent extends UserReservationsEvent {
  final String uid;

  GetUserReservationsEvent(this.uid);

  @override
  List<Object> get props => [uid];
}