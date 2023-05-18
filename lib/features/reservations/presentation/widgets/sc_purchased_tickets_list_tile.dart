import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/screening_bloc.dart';
import 'package:south_cinema/injection_container.dart';

class SCPurchasedTicketsListTile extends StatelessWidget {
  const SCPurchasedTicketsListTile({
    Key? key,
    required this.purchase,
  }) : super(key: key);

  final Purchase purchase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ScreeningBloc>()
        ..add(
          GetScreeningByIdEvent(purchase.screeningId),
        ),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 150,
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: BlocBuilder<ScreeningBloc, ScreeningState>(
          builder: (context, state) {
            if (state is Loaded) {
              final dateFormat = DateFormat.Hm().add_yMd();
              final dateTimeStr =
                  dateFormat.format(state.screening.date.toDate());

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.screening.movieTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    dateTimeStr,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    state.room.name,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    'Reservation id: ${purchase.id.substring(purchase.id.length - 6)}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...purchase.tickets.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Row: ${entry.key.substring(0, 2)}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                'Seat: ${entry.key.substring(2)}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                entry.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Total price: ${purchase.totalPrice}\$',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              );
            } else if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('Unable to fetch data.'),
              );
            }
          },
        ),
      ),
    );
  }
}
