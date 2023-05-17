part of 'user_purchased_tickets_bloc.dart';

abstract class UserPurchasedTicketsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserPurchasedTicketsEvent extends UserPurchasedTicketsEvent {
  final String uid;

  GetUserPurchasedTicketsEvent(this.uid);

  @override
  List<Object> get props => [uid];
}