import 'package:flutter/material.dart';

class SCCategoryChoiceChip extends StatelessWidget {
  const SCCategoryChoiceChip({
    super.key,
    required this.categoryName,
    required this.category,
    required this.selected,
    required this.onSelected,
  });

  final String categoryName;
  final int category;
  final int selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        categoryName,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: selected == category
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          shadows: [
            selected == category
                ? Shadow(
              color: Theme.of(context).colorScheme.secondary,
              blurRadius: 5,
            )
                : const Shadow()
          ],
        ),
      ),
      selected: selected == category,
      onSelected: (bool selected) => onSelected(),
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedColor: Theme.of(context).colorScheme.background,
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      elevation: 0,
      pressElevation: 0,
      shape: ContinuousRectangleBorder(
        side: BorderSide(
            width: 0, color: Theme.of(context).colorScheme.background),
      ),
    );
  }
}