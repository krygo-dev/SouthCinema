import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/core/widgets/sc_nav_drawer.dart';
import 'package:south_cinema/features/reservations/presentation/bloc/user_reservations_bloc.dart';
import 'package:south_cinema/features/reservations/presentation/widgets/sc_reservation_list_tile.dart';
import 'package:south_cinema/injection_container.dart';

class UserReservationsPage extends StatelessWidget {
  const UserReservationsPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      drawer: const SCNavDrawer(),
      body: BlocProvider(
        create: (_) =>
            sl<UserReservationsBloc>()..add(GetUserReservationsEvent(uid)),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 572),
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
            color: Theme.of(context).colorScheme.onBackground,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Reservations',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<UserReservationsBloc, UserReservationsState>(
                    builder: (context, state) {
                      if (state is UserReservationsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is UserReservationsLoaded) {
                        if (state.reservationsList.isEmpty) {
                          return const Center(
                            child: Text('You don\'t have any reservations.'),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.reservationsList.length,
                            itemBuilder: (context, index) {
                              return SCReservationListTile(
                                reservation: state.reservationsList[index],
                              );
                            },
                          );
                        }
                      } else {
                        return const Center(
                          child: Text('Unexpected error'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}