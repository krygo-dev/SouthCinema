import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/features/movies/presentation/bloc/movies_bloc.dart';

class SCPlayedAnnouncedRow extends StatelessWidget {
  const SCPlayedAnnouncedRow({
    Key? key,
    this.selected = screeningNow,
    required this.onSelected,
  }) : super(key: key);

  static const screeningNow = 0;
  static const announced = 1;

  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ChoiceChip(
          label: Text(
            'SCREENING NOW',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: selected == screeningNow
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary,
              shadows: [
                selected == screeningNow
                    ? Shadow(
                        color: Theme.of(context).colorScheme.secondary,
                        blurRadius: 5,
                      )
                    : const Shadow()
              ],
            ),
          ),
          selected: selected == screeningNow,
          onSelected: (bool selected) {
            onSelected(screeningNow);
            BlocProvider.of<MoviesBloc>(context)
                .add(GetCurrentlyPlayedMoviesEvent());
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
              color: selected == announced
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary,
              shadows: [
                selected == announced
                    ? Shadow(
                        color: Theme.of(context).colorScheme.secondary,
                        blurRadius: 5,
                      )
                    : const Shadow()
              ],
            ),
          ),
          selected: selected == announced,
          onSelected: (bool selected) {
            onSelected(announced);
            // BlocProvider.of<MoviesBloc>(context).add(GetAnnouncedMoviesEvent());
            BlocProvider.of<MoviesBloc>(context)
                .add(GetCurrentlyPlayedMoviesEvent());
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
