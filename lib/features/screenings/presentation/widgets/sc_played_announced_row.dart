import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:south_cinema/core/widgets/sc_category_choice_chip.dart';

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
        SCCategoryChoiceChip(
          categoryName: 'SCREENING NOW',
          category: screeningNow,
          selected: selected,
          onSelected: () {
            onSelected(screeningNow);
            BlocProvider.of<MoviesBloc>(context)
                .add(GetCurrentlyPlayedMoviesEvent());
          },
        ),
        Container(
          width: 2,
          height: 29,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        SCCategoryChoiceChip(
            categoryName: 'ANNOUNCED',
            category: announced,
            selected: selected,
            onSelected: () {
              onSelected(announced);
              BlocProvider.of<MoviesBloc>(context)
                  .add(GetAnnouncedMoviesEvent());
            }),
      ],
    );
  }
}


