part of 'purchase_bloc.dart';

abstract class PurchaseState extends Equatable {
  @override
  List<Object> get props => [];
}

class PurchaseEmpty extends PurchaseState {}

class PurchaseLoading extends PurchaseState {}

class PurchaseLoaded extends PurchaseState {
  final bool purchaseSuccessful;

  PurchaseLoaded({required this.purchaseSuccessful});

  @override
  List<Object> get props => [purchaseSuccessful];
}

class PurchaseError extends PurchaseState {
  final String message;

  PurchaseError({required this.message});

  @override
  List<Object> get props => [message];
}
