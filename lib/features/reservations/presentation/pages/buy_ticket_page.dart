import 'package:flutter/material.dart';
import 'package:south_cinema/core/navigation/buy_ticket_page_arguments.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_book_buy_ticket_row.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_card_details_column.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_personal_details_column.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_room_title_date.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_text_button.dart';

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

  static const List<String> tickets = [
    'ADULT TICKET 7\$',
    'STUDENT TICKET 4\$',
  ];

  Map<String, String> selectedTickets = {};
  double totalPrice = 0;

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
                constraints: const BoxConstraints(
                  minHeight: 572,
                ),
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
                          (seat) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ROW ${seat.substring(0, 2)} SEAT ${seat.substring(2)}  -  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      selectedTickets[seat] = tickets.first;
                                      calculateTotalPrice(seat);
                                    },
                                    child: Container(
                                        width: 150,
                                        height: 16,
                                        padding: const EdgeInsets.all(2),
                                        margin: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: Text(tickets.first)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      selectedTickets[seat] = tickets.last;
                                      calculateTotalPrice(seat);
                                    },
                                    child: Container(
                                        width: 150,
                                        height: 16,
                                        padding: const EdgeInsets.all(2),
                                        margin: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: Text(tickets.last)),
                                  ),
                                ],
                              ),
                            ],
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
                            'TOTAL PRICE: $totalPrice\$',
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
                      child: SCPersonalDetailsColumn(
                        fullNameController: _fullNameController,
                        emailController: _emailController,
                        mobileNumberController: _mobileNumberController,
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
                      child: SCCardDetailsColumn(
                        cardFullNameController: _cardFullNameController,
                        cardNumberController: _cardNumberController,
                        cardExpiryDateController: _cardExpiryDateController,
                        cardCVVController: _cardCVVController,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SCTextButton(buttonLabel: 'PAY', onPressed: () {}),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateTotalPrice(String seat) {
    double sum = 0;
    totalPrice = 0;

    selectedTickets.forEach((key, value) {
      String numberStr = value.substring(value.length - 2, value.length - 1);
      sum += double.parse(numberStr);
    });

    setState(() {
      totalPrice = sum;
    });
  }
}
