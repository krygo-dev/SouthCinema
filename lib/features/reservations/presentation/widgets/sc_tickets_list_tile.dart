import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:south_cinema/core/util/tickets_tile_state.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/screening_bloc.dart';
import 'package:south_cinema/injection_container.dart';

class SCTicketsListTile extends StatelessWidget {
  const SCTicketsListTile({
    super.key,
    required this.tile,
  });

  final TicketsTileState tile;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      key: tile.key,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: BoxConstraints(
        minHeight: tile.expanded ? 350 : 200,
      ),
      child: BlocProvider(
        create: (_) => sl<ScreeningBloc>()
          ..add(GetScreeningByIdEvent(tile.purchase.screeningId)),
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
                    'Purchase id: ${tile.purchase.id.substring(tile.purchase.id.length - 6)}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...tile.purchase.tickets.entries.map((entry) {
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
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Total price: ${tile.purchase.totalPrice}\$',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                      tile.expanded
                          ? const SizedBox(height: 16)
                          : const SizedBox(height: 0),
                    ],
                  ),
                  AnimatedSize(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 500),
                    child: QrImageView(
                      data: tile.purchase.id,
                      size: tile.expanded ? 150 : 0,
                      eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
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
