import 'package:flutter/material.dart';
import 'package:south_cinema/core/navigation/buy_ticket_page_arguments.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_book_buy_ticket_row.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_room_title_date.dart';

class BuyTicketPage extends StatelessWidget {
  const BuyTicketPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final BuyTicketPageArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      body: Column(
        children: [
          SCBookBuyTicketRow(bookTicketSelected: false, onSelected: () {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Container(
              width: double.infinity,
              height: 572,
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
              color: Theme.of(context).colorScheme.onBackground,
              child: Column(
                children: [
                  SCRoomTitleDate(
                    roomID: arguments.room.id,
                    movieTitle: arguments.screening.movieTitle,
                    dateTime: arguments.dateTimeStr,
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  ...arguments.chosenSeats
                      .map(
                        (seat) => SCTicketsRowDropdown(
                          seat: seat,
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SCTicketsRowDropdown extends StatefulWidget {
  const SCTicketsRowDropdown({
    super.key,
    required this.seat,
  });

  final String seat;

  @override
  State<SCTicketsRowDropdown> createState() => _SCTicketsRowDropdownState();
}

class _SCTicketsRowDropdownState extends State<SCTicketsRowDropdown> {
  List<String> tickets = ['ADULT TICKET 7\$', 'STUDENT TICKET 4\$'];
  String currentValue = 'ADULT TICKET 7\$';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'ROW ${widget.seat.substring(0, 2)} SEAT ${widget.seat.substring(2)} - ',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        DropdownButton(
          value: currentValue,
          items: tickets
              .map(
                (ticket) => DropdownMenuItem(
                  value: ticket,
                  child: Text(ticket),
                ),
              )
              .toList(),
          onChanged: (String? newValue) {
            setState(() {
              currentValue = newValue!;
            });
          },
        ),
      ],
    );
  }
}
