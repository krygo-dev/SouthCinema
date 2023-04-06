import 'package:flutter/material.dart';
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';

class SCRepertoireListItem extends StatelessWidget {
  const SCRepertoireListItem({
    super.key,
    required this.repertoire,
  });

  final RepertoireScreening repertoire;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                repertoire.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: repertoire.screenings.map((screening) {
              return Container(
                width: 41,
                height: 24,
                margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                alignment: Alignment.center,
                color: Theme.of(context).colorScheme.background,
                child: Text(
                  screening['time'],
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}