import 'dart:async';
import 'package:flutter/material.dart';
import 'package:south_cinema/core/util/tickets_tile_state.dart';
import 'package:south_cinema/features/reservations/presentation/widgets/sc_tickets_list_tile.dart';

class SCTicketsColumn extends StatefulWidget {
  const SCTicketsColumn({
    Key? key,
    required this.tilesState,
  }) : super(key: key);

  final List<TicketsTileState> tilesState;

  @override
  State<SCTicketsColumn> createState() => _SCTicketsColumnState();
}

class _SCTicketsColumnState extends State<SCTicketsColumn> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.tilesState.length,
      itemBuilder: (context, index) {
        TicketsTileState tile = widget.tilesState.elementAt(index);

        return GestureDetector(
          onTap: () {
            setState(() {
              tile.expanded = !tile.expanded;
              Timer(
                const Duration(milliseconds: 500),
                () => Scrollable.ensureVisible(
                  tile.key.currentContext!,
                  duration: const Duration(milliseconds: 300),
                  alignment: 0.3,
                  alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
                ),
              );
            });
          },
          child: SCTicketsListTile(tile: tile),
        );
      },
    );
  }
}
