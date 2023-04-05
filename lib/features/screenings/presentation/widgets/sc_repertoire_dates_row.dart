import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:south_cinema/core/theme/colors.dart';

class SCRepertoireDatesRow extends StatefulWidget {
  const SCRepertoireDatesRow({Key? key}) : super(key: key);

  @override
  State<SCRepertoireDatesRow> createState() => _SCRepertoireDatesRowState();
}

class _SCRepertoireDatesRowState extends State<SCRepertoireDatesRow> {
  int? _value = 0;
  final dateFormat = DateFormat('dd/MM/yyyy');
  final currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.calendar_today_outlined),
        for (int index = 0; index < 4; index++)
          ChoiceChip(
            label: SizedBox(
              height: 43,
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dateFormat
                        .format(currentDateTime.add(Duration(days: index))),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      shadows: [
                        _value == index
                            ? const Shadow(
                          color: secondaryColor,
                          blurRadius: 5,
                        )
                            : const Shadow()
                      ],
                    ),
                  ),
                  Text(
                    DateFormat('EEEE')
                        .format(currentDateTime.add(Duration(days: index))),
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      shadows: [
                        _value == index ? const Shadow(
                          color: primaryColor,
                          blurRadius: 5,
                        ) : const Shadow()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            selected: _value == index,
            onSelected: (bool selected) {
              setState(() {
                _value = index;
              });
            },
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            selectedColor: Theme.of(context).colorScheme.onBackground,
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            elevation: 0,
            pressElevation: 0,
            shape: ContinuousRectangleBorder(
              side: BorderSide(
                  width: 0, color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
      ],
    );
  }
}