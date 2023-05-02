import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:south_cinema/core/navigation/reservation_purchase_page_arguments.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/core/widgets/sc_book_buy_ticket_row.dart';
import 'package:south_cinema/core/widgets/sc_room_title_date.dart';
import 'package:south_cinema/core/widgets/sc_text_button.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/reservations/presentation/bloc/reservation_bloc.dart';
import 'package:south_cinema/features/reservations/presentation/widgets/sc_personal_details_column.dart';
import 'package:south_cinema/injection_container.dart';

class ReservationPage extends StatelessWidget {
  ReservationPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ReservationPurchasePageArguments arguments;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      body: BlocProvider(
        create: (_) => sl<ReservationBloc>(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SCBookBuyTicketRow(bookTicketSelected: true, onSelected: () {}),
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
                  child: BlocBuilder<ReservationBloc, ReservationState>(
                    builder: (context, state) {
                      if (state is ReservationLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ReservationLoaded) {
                        return Center(
                          child: Column(
                            children: [
                              Text(
                                'Reservation completed',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(height: 16),
                              SCTextButton(
                                buttonLabel: 'Go back',
                                onPressed: () => context.goNamed('screenings'),
                              ),
                            ],
                          ),
                        );
                      } else if (state is ReservationError) {
                        return Center(
                          child: Column(
                            children: [
                              Text(
                                state.message,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(height: 16),
                              SCTextButton(
                                buttonLabel: 'Try again',
                                onPressed: () {
                                  context.pushReplacementNamed(
                                    'reservation',
                                    extra: arguments,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            SCRoomTitleDate(
                              roomID: arguments.room.id,
                              movieTitle: arguments.screening.movieTitle,
                              dateTime: arguments.dateTimeStr,
                            ),
                            const SizedBox(height: 27),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 20),
                              child: Text(
                                'PERSONAL DETAILS',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: SCPersonalDetailsColumn(
                                fullNameController: _fullNameController,
                                emailController: _emailController,
                                mobileNumberController: _mobileNumberController,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SCTextButton(
                              buttonLabel: 'BOOK',
                              onPressed: () {
                                final newReservation = Reservation(
                                  id: '',
                                  screeningId: arguments.screening.id,
                                  fullName: _fullNameController.text,
                                  createdAt: Timestamp.now(),
                                  phoneNumber: _mobileNumberController.text,
                                  email: _emailController.text,
                                  seats: arguments.chosenSeats,
                                );

                                BlocProvider.of<ReservationBloc>(context).add(
                                  CreateNewReservationEvent(newReservation),
                                );
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
