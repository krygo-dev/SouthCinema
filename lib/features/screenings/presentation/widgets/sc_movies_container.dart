import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/presentation/bloc/movies_bloc.dart';

class SCMoviesContainer extends StatelessWidget {
  const SCMoviesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Container(
        color: Theme.of(context).colorScheme.onBackground,
        padding: const EdgeInsets.symmetric(
            horizontal: 17, vertical: 12),
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
                  Movie movie = state.moviesList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          movie.posterUrl,
                          width: 170,
                          height: 258,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        SizedBox(
                          width: 137,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                movie.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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