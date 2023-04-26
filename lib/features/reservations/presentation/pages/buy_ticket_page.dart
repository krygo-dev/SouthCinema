import 'package:flutter/material.dart';
import 'package:south_cinema/core/navigation/buy_ticket_page_arguments.dart';
import 'package:south_cinema/core/text_input_formatters.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/features/reservations/presentation/widgets/sc_details_input_row.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_book_buy_ticket_row.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_room_title_date.dart';

class BuyTicketPage extends StatefulWidget {
  const BuyTicketPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final BuyTicketPageArguments arguments;

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _cardFullNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardExpiryDateController =
      TextEditingController();
  final TextEditingController _cardCVVController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SCBookBuyTicketRow(bookTicketSelected: false, onSelected: () {}),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Container(
                width: double.infinity,
                height: 572,
                padding:
                    const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
                color: Theme.of(context).colorScheme.onBackground,
                child: Column(
                  children: [
                    SCRoomTitleDate(
                      roomID: widget.arguments.room.id,
                      movieTitle: widget.arguments.screening.movieTitle,
                      dateTime: widget.arguments.dateTimeStr,
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    ...widget.arguments.chosenSeats
                        .map(
                          (seat) => SCTicketsRowDropdown(
                            seat: seat,
                          ),
                        )
                        .toList(),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL PRICE: ',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 20),
                      child: Text(
                        'PERSONAL DETAILS',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SCDetailsInputRow(
                              label: 'Full name:',
                              controller: _fullNameController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SCDetailsInputRow(
                              label: 'E-mail:',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: SCDetailsInputRow(
                              label: 'Mobile number:',
                              controller: _mobileNumberController,
                              keyboardType: TextInputType.phone,
                              formatters: mobileNumberFormatters,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 20),
                      child: Text(
                        'CARD DETAILS',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SCDetailsInputRow(
                              label: 'Full name:',
                              controller: _cardFullNameController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SCDetailsInputRow(
                              label: 'Card number:',
                              controller: _cardNumberController,
                              keyboardType: TextInputType.number,
                              formatters: cardNumberFormatters,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 90,
                                child: SCDetailsInputRow(
                                  label: 'Exp. date:',
                                  controller: _cardExpiryDateController,
                                  keyboardType: TextInputType.number,
                                  formatters: cardExpiryDateFormatters,
                                  textFieldWidth: 36,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 60,
                                child: SCDetailsInputRow(
                                  label: 'CVV:',
                                  controller: _cardCVVController,
                                  keyboardType: TextInputType.number,
                                  formatters: cardCVVCodeFormatters,
                                  textFieldWidth: 31,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Text(
            'ROW ${widget.seat.substring(0, 2)} SEAT ${widget.seat.substring(2)}  -  ',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          Container(
            width: 150,
            // height: 16,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Column(
              children: [Text(tickets.first), Text(tickets.last)],
            ),
          ),
        ],
      ),
    );
  }
}
