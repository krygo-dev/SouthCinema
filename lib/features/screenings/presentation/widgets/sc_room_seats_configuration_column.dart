import 'package:flutter/material.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_seat_container.dart';

class SCRoomSeatsConfigurationColumn extends StatefulWidget {
  const SCRoomSeatsConfigurationColumn({
    super.key,
    required this.seatsConfiguration,
    required this.seatsTaken,
    required this.chosenSeats,
  });

  final List<int> seatsConfiguration;
  final List<String> seatsTaken;
  final List<String> chosenSeats;

  @override
  State<SCRoomSeatsConfigurationColumn> createState() =>
      _SCRoomSeatsConfigurationColumnState();
}

class _SCRoomSeatsConfigurationColumnState
    extends State<SCRoomSeatsConfigurationColumn> {
  void _handleSeatOnTap(String seatId) {
    if (!widget.seatsTaken.contains(seatId)) {
      setState(() {
        widget.chosenSeats.contains(seatId)
            ? widget.chosenSeats.remove(seatId)
            : widget.chosenSeats.add(seatId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
      List<Widget>.generate(widget.seatsConfiguration.length, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: index == 5 ? 22 : 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            List<Widget>.generate(widget.seatsConfiguration[index], (seat) {
              String rowStr = index + 1 < 10 ? '0${index + 1}' : '${index + 1}';
              String seatStr = seat + 1 < 10 ? '0${seat + 1}' : '${seat + 1}';
              String seatId = rowStr + seatStr;
              Color seatColor;

              if (widget.seatsTaken.contains(seatId)) {
                seatColor = Theme.of(context).colorScheme.error;
              } else if (widget.chosenSeats.contains(seatId)) {
                seatColor = Theme.of(context).colorScheme.primary;
              } else {
                seatColor = Theme.of(context).colorScheme.secondary;
              }

              return InkWell(
                onTap: () => _handleSeatOnTap(seatId),
                child: SCSeatContainer(seatColor: seatColor),
              );
            }),
          ),
        );
      }),
    );
  }
}