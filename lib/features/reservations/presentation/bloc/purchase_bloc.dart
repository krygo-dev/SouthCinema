import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/reservations/domain/usecases/create_new_purchase.dart';

part 'purchase_event.dart';

part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final CreateNewPurchase createNewPurchase;

  PurchaseBloc({required this.createNewPurchase}) : super(PurchaseEmpty()) {
    on<CreateNewPurchaseEvent>(_createNewPurchase);
  }

  void _createNewPurchase(
    CreateNewPurchaseEvent event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(PurchaseLoading());
    final errorOrResult = await createNewPurchase(purchase: event.purchase);
    errorOrResult.fold(
      (error) => emit(PurchaseError(message: error.message)),
      (result) => emit(PurchaseLoaded(purchaseSuccessful: result)),
    );
  }
}
