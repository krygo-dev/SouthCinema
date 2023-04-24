import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/screening_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_book_buy_ticket_row.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_room_legend_column.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_room_seats_configuration_column.dart';

import '../../../../injection_container.dart';

class ScreeningPage extends StatefulWidget {
  const ScreeningPage({Key? key, required this.screeningId}) : super(key: key);

  final String screeningId;

  @override
  State<ScreeningPage> createState() => _ScreeningPageState();
}

class _ScreeningPageState extends State<ScreeningPage> {
  final List<String> chosenSeats = [];
  bool _bookTicketSelected = true;

  void _handleOnBookBuySelect() {
    setState(() {
      _bookTicketSelected = !_bookTicketSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      body: BlocProvider(
        create: (_) =>
            sl<ScreeningBloc>()..add(GetScreeningByIdEvent(widget.screeningId)),
        child: Column(
          children: [
            SCBookBuyTicketRow(
              bookTicketSelected: _bookTicketSelected,
              onSelected: _handleOnBookBuySelect,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Container(
                width: double.infinity,
                height: 572,
                padding:
                    const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
                color: Theme.of(context).colorScheme.onBackground,
                child: BlocBuilder<ScreeningBloc, ScreeningState>(
                  builder: (context, state) {
                    if (state is Loaded) {
                      final dateTime = state.screening.date.toDate();
                      final dateFormat = DateFormat.Hm().add_yMd();

                      return Column(
                        children: [
                          Image.asset(
                            state.room.id == 'room_1'
                                ? 'assets/images/room_1.png'
                                : 'assets/images/room_1.png',
                            // width: 130,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            state.screening.movieTitle,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            dateFormat.format(dateTime),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 27,
                          ),
                          Container(
                            width: double.infinity,
                            height: 18,
                            color: Theme.of(context).colorScheme.onSurface,
                            alignment: Alignment.center,
                            child: Text(
                              'SCREEN',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(
                            height: 37,
                          ),
                          SCRoomSeatsConfigurationColumn(
                            seatsConfiguration: state.room.seatsConfiguration,
                            seatsTaken: state.screening.seatsTaken,
                            chosenSeats: chosenSeats,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const SCRoomLegendColumn(),
                          const SizedBox(
                            height: 44,
                          ),
                          TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Theme.of(context).colorScheme.onSurface,
                                ),
                                shape: MaterialStatePropertyAll<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                                fixedSize: const MaterialStatePropertyAll<Size>(
                                  Size(107, 34),
                                )),
                            child: Text(
                              _bookTicketSelected ? 'BOOK' : 'BUY',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ],
                      );
                    } else if (state is Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is Error) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return const Center(
                        child: Text('Empty'),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
