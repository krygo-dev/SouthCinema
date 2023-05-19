import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:south_cinema/core/navigation/navigation_router.dart';
import 'package:south_cinema/core/navigation/reservation_purchase_page_arguments.dart';
import 'package:south_cinema/core/util/set_text_editing_controller_value.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/core/widgets/sc_book_buy_ticket_row.dart';
import 'package:south_cinema/core/widgets/sc_nav_drawer.dart';
import 'package:south_cinema/core/widgets/sc_room_title_date.dart';
import 'package:south_cinema/core/widgets/sc_text_button.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';
import 'package:south_cinema/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/reservations/presentation/bloc/reservation_bloc.dart';
import 'package:south_cinema/features/reservations/presentation/widgets/sc_personal_details_column.dart';
import 'package:south_cinema/features/reservations/presentation/widgets/sc_result_container.dart';
import 'package:south_cinema/features/user_profile/presentation/bloc/user_bloc.dart';
import 'package:south_cinema/injection_container.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ReservationPurchasePageArguments arguments;

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  AuthUser? currentUser;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      drawer: const SCNavDrawer(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<ReservationBloc>(),
          ),
          BlocProvider(
            create: (context) =>
                sl<AuthenticationBloc>()..add(GetCurrentUserEvent()),
          ),
          BlocProvider(create: (_) => sl<UserBloc>()),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationLoaded) {
                  currentUser = state.authUser;

                  if (currentUser != null) {
                    BlocProvider.of<UserBloc>(context)
                        .add(GetUserByIdEvent(currentUser!.uid));
                  }
                }
              },
            ),
            BlocListener<UserBloc, UserState>(listener: (context, state) {
              if (state is UserLoaded) {
                setTextEditingControllerValue(
                  _fullNameController,
                  state.user.name,
                );
                setTextEditingControllerValue(
                  _emailController,
                  state.user.email,
                );
                setTextEditingControllerValue(
                  _mobileNumberController,
                  state.user.contactNumber,
                );
              }
            }),
            BlocListener<ReservationBloc, ReservationState>(
              listener: (context, state) {
                if (state is ReservationError) {
                  final snackBar = SnackBar(
                    content: Text(state.message),
                    duration: const Duration(milliseconds: 1500),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 23, vertical: 12),
                    color: Theme.of(context).colorScheme.onBackground,
                    child: BlocBuilder<ReservationBloc, ReservationState>(
                      builder: (context, state) {
                        if (state is ReservationLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ReservationLoaded) {
                          return Center(
                            child: SCResultContainer(
                              text: 'Reservation process completed',
                              buttonLabel: 'Go back',
                              onPressed: () =>
                                  context.goNamed(Routes.screenings),
                            ),
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SCRoomTitleDate(
                                    roomID: widget.arguments.room.id,
                                    movieTitle:
                                        widget.arguments.screening.movieTitle,
                                    dateTime: widget.arguments.dateTimeStr,
                                  ),
                                  const SizedBox(height: 27),
                                  Text(
                                    'SELECTED SEATS',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  const SizedBox(height: 10),
                                  ...widget.arguments.chosenSeats.map((seat) {
                                    return Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'ROW ${seat.substring(0, 2)} SEAT ${seat.substring(2)}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    );
                                  }),
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
                                      mobileNumberController:
                                          _mobileNumberController,
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              ),
                              SCTextButton(
                                buttonLabel: 'BOOK',
                                onPressed: () {
                                  final newReservation = Reservation(
                                    id: '',
                                    screeningId: widget.arguments.screening.id,
                                    fullName: _fullNameController.text,
                                    userId: currentUser?.uid ?? '',
                                    createdAt: Timestamp.now(),
                                    phoneNumber: _mobileNumberController.text,
                                    email: _emailController.text,
                                    seats: widget.arguments.chosenSeats,
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
      ),
    );
  }
}
