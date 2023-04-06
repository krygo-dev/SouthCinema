import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:south_cinema/core/theme/colors.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/repertoire_bloc.dart';

class SCRepertoireDatesRow extends StatefulWidget {
  const SCRepertoireDatesRow({Key? key}) : super(key: key);

  @override
  State<SCRepertoireDatesRow> createState() => _SCRepertoireDatesRowState();
}

class _SCRepertoireDatesRowState extends State<SCRepertoireDatesRow> {
  int _selected = 0;
  final dateFormat = DateFormat('dd/MM/yyyy');
  final currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: Theme.of(context).colorScheme.onBackground,
      child: Row(
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
                          _selected == index
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
                          _selected == index
                              ? const Shadow(
                                  color: primaryColor,
                                  blurRadius: 5,
                                )
                              : const Shadow()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              selected: _selected == index,
              onSelected: (bool selected) {
                setState(() {
                  _selected = index;
                  BlocProvider.of<RepertoireBloc>(context).add(
                    GetRepertoireForDateEvent(
                      '15/03/2023',
                      // dateFormat
                      //     .format(currentDateTime.add(Duration(days: index))),
                    ),
                  );
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
                    width: 0,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
        ],
      ),
    );
  }
}
