import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_movies_list_item.dart';

class SCMoviesContainer extends StatelessWidget {
  const SCMoviesContainer({super.key, this.reversed = false});

  final bool reversed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Container(
        color: Theme.of(context).colorScheme.onBackground,
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
        constraints: const BoxConstraints(
          minHeight: 600,
          maxHeight: double.infinity,
        ),
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.moviesList.length,
                itemBuilder: (context, index) {
                  return SCMovieListItem(
                    movie: state.moviesList[index],
                    reversed: reversed,
                  );
                },
              );
            } else if (state is MoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviesError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Empty'),
              );
            }
          },
        ),
      ),
    );
  }
}
