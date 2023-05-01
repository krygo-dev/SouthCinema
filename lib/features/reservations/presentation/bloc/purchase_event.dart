part of 'purchase_bloc.dart';

abstract class PurchaseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateNewPurchaseEvent extends PurchaseEvent {
  final Purchase purchase;

  CreateNewPurchaseEvent(this.purchase);

  @override
  List<Object> get props => [purchase];
}


class GetUserPurchasedTicketsEvent extends PurchaseEvent {
  final String uid;

  GetUserPurchasedTicketsEvent(this.uid);

  @override
  List<Object> get props => [uid];
}