import 'package:flutter/material.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_seat_container.dart';

class SCRoomLegendColumn extends StatelessWidget {
  const SCRoomLegendColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SCSeatContainer(
              seatColor:
              Theme.of(context).colorScheme.secondary,
            ),
            Text(
              '- EMPTY SEAT',
              style:
              Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SCSeatContainer(
              seatColor:
              Theme.of(context).colorScheme.primary,
            ),
            Text(
              '- CHOSEN SEAT',
              style:
              Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SCSeatContainer(
              seatColor:
              Theme.of(context).colorScheme.error,
            ),
            Text(
              '- NOT AVAILABLE SEAT',
              style:
              Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ],
    );
  }
}