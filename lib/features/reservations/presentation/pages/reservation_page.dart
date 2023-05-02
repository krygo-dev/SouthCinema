import 'package:flutter/material.dart';
import 'package:south_cinema/core/navigation/reservation_purchase_page_arguments.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/core/widgets/sc_book_buy_ticket_row.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ReservationPurchasePageArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      body: Column(
        children: [
          SCBookBuyTicketRow(bookTicketSelected: true, onSelected: () {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Container(
              width: double.infinity,
              height: 572,
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
