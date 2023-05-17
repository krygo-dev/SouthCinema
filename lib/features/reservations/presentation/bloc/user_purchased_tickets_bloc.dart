import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/reservations/domain/usecases/get_user_purchased_tickets.dart';

part 'user_purchased_tickets_event.dart';

part 'user_purchased_tickets_state.dart';

class UserPurchasedTicketsBloc
    extends Bloc<UserPurchasedTicketsEvent, UserPurchasedTicketsState> {
  final GetUserPurchasedTickets getUserPurchasedTickets;

  UserPurchasedTicketsBloc({required this.getUserPurchasedTickets})
      : super(UserPurchasedTicketsEmpty()) {
    on<GetUserPurchasedTicketsEvent>(_getUserPurchasedTickets);
  }

  FutureOr<void> _getUserPurchasedTickets(
    GetUserPurchasedTicketsEvent event,
    Emitter<UserPurchasedTicketsState> emit,
  ) async {
    emit(UserPurchasedTicketsLoading());
    final errorOrPurchasedTicketsList =
        await getUserPurchasedTickets(uid: event.uid);

    errorOrPurchasedTicketsList.fold(
      (error) => emit(UserPurchasedTicketsError(message: error.message)),
      (purchasedTicketsList) => emit(
        UserPurchasedTicketsLoaded(purchasedTicketsList: purchasedTicketsList),
      ),
    );
  }
}
