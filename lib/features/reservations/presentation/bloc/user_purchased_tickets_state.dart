part of 'user_purchased_tickets_bloc.dart';

abstract class UserPurchasedTicketsState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserPurchasedTicketsEmpty extends UserPurchasedTicketsState {}

class UserPurchasedTicketsLoading extends UserPurchasedTicketsState {}

class UserPurchasedTicketsLoaded extends UserPurchasedTicketsState {
  final List<Purchase> purchasedTicketsList;

  UserPurchasedTicketsLoaded({required this.purchasedTicketsList});

  @override
  List<Object> get props => [purchasedTicketsList];
}

class UserPurchasedTicketsError extends UserPurchasedTicketsState {
  final String message;

  UserPurchasedTicketsError({required this.message});

  @override
  List<Object> get props => [message];
}