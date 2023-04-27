import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:south_cinema/core/navigation/buy_ticket_page_arguments.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/screening_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_book_buy_ticket_row.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_room_legend_column.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_room_seats_configuration_column.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_room_title_date.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_text_button.dart';

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
                      final dateFormat = DateFormat.Hm().add_yMd();
                      final dateTimeStr =
                          dateFormat.format(state.screening.date.toDate());

                      return Column(
                        children: [
                          SCRoomTitleDate(
                            roomID: state.room.id,
                            movieTitle: state.screening.movieTitle,
                            dateTime: dateTimeStr,
                          ),
                          const SizedBox(height: 27),
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
                          const SizedBox(height: 37),
                          SCRoomSeatsConfigurationColumn(
                            seatsConfiguration: state.room.seatsConfiguration,
                            seatsTaken: state.screening.seatsTaken,
                            chosenSeats: chosenSeats,
                          ),
                          const SizedBox(height: 40),
                          const SCRoomLegendColumn(),
                          const SizedBox(height: 44),
                          SCTextButton(
                            onPressed: () {
                              if (chosenSeats.isEmpty) return;

                              _bookTicketSelected
                                  ? context.pushNamed('reservation')
                                  : context.pushNamed('buy_ticket',
                                      extra: BuyTicketPageArguments(
                                        room: state.room,
                                        screening: state.screening,
                                        dateTimeStr: dateTimeStr,
                                        chosenSeats: chosenSeats,
                                      ));
                            },
                            buttonLabel: _bookTicketSelected ? 'BOOK' : 'BUY',
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
