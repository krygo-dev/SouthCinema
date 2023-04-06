import 'package:flutter/material.dart';

class SCPlayedAnnouncedRow extends StatefulWidget {
  const SCPlayedAnnouncedRow({Key? key}) : super(key: key);

  @override
  State<SCPlayedAnnouncedRow> createState() => _SCPlayedAnnouncedRowState();
}

class _SCPlayedAnnouncedRowState extends State<SCPlayedAnnouncedRow> {
  static const screeningNow = 0;
  static const announced = 1;
  int _selected = screeningNow;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ChoiceChip(
          label: Text(
            'SCREENING NOW',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: _selected == screeningNow
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary,
              shadows: [
                _selected == screeningNow
                    ? Shadow(
                        color: Theme.of(context).colorScheme.secondary,
                        blurRadius: 5,
                      )
                    : const Shadow()
              ],
            ),
          ),
          selected: _selected == screeningNow,
          onSelected: (bool selected) {
            setState(() {
              _selected = screeningNow;
              // BlocProvider.of<MoviesBloc>(context).add(GetCurrentlyPlayedMoviesEvent());
            });
          },
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
        ),
        Container(
          width: 2,
          height: 29,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        ChoiceChip(
          label: Text(
            'ANNOUNCED',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: _selected == announced
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary,
              shadows: [
                _selected == announced
                    ? Shadow(
                        color: Theme.of(context).colorScheme.secondary,
                        blurRadius: 5,
                      )
                    : const Shadow()
              ],
            ),
          ),
          selected: _selected == announced,
          onSelected: (bool selected) {
            setState(() {
              _selected = announced;
              // BlocProvider.of<MoviesBloc>(context).add(GetAnnouncedMoviesEvent());
            });
          },
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
        ),
      ],
    );
  }
}
