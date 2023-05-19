import 'package:flutter/material.dart';

class SCTicketChoiceChip extends StatelessWidget {
  const SCTicketChoiceChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  final String label;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
      selected: isSelected,
      onSelected: (bool newValue) {
        onSelect();
      },
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedColor: Theme.of(context).colorScheme.onSurface,
      padding: const EdgeInsets.all(4),
      labelPadding: EdgeInsets.zero,
      elevation: 0,
      pressElevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: isSelected
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.background,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
