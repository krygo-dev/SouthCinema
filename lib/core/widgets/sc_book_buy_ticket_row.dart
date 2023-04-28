import 'package:flutter/material.dart';
import 'package:south_cinema/core/widgets/sc_category_choice_chip.dart';

class SCBookBuyTicketRow extends StatelessWidget {
  const SCBookBuyTicketRow({
    Key? key,
    required this.bookTicketSelected,
    required this.onSelected,
  }) : super(key: key);

  final bool bookTicketSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    int selected = bookTicketSelected ? 0 : 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
      child: SizedBox(
        height: 23,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SCCategoryChoiceChip(
              categoryName: 'BOOK NOW',
              category: 0,
              selected: selected,
              onSelected: () {
                if (!bookTicketSelected) onSelected();
              },
            ),
            Container(
              width: 2,
              height: 29,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            SCCategoryChoiceChip(
              categoryName: 'BUY TICKET',
              category: 1,
              selected: selected,
              onSelected: () {
                if (bookTicketSelected) onSelected();
              },
            ),
          ],
        ),
      ),
    );
  }
}