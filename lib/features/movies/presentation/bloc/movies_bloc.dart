import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/domain/usecases/get_announced_movies.dart';
import 'package:south_cinema/features/movies/domain/usecases/get_currently_played_movies.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetCurrentlyPlayedMovies getCurrentlyPlayedMovies;
  final GetAnnouncedMovies getAnnouncedMovies;

  MoviesBloc({
    required this.getCurrentlyPlayedMovies,
    required this.getAnnouncedMovies,
  }) : super(Empty()) {
    on<GetCurrentlyPlayedMoviesEvent>(_getCurrentlyPlayedMovies);
    on<GetAnnouncedMoviesEvent>(_getAnnouncedMovies);
  }

  FutureOr<void> _getCurrentlyPlayedMovies(
    GetCurrentlyPlayedMoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    emit(Loading());
    final errorOrMovies = await getCurrentlyPlayedMovies();
    errorOrMovies.fold(
      (error) => emit(Error(message: error.message)),
      (movies) => emit(Loaded(moviesList: movies)),
    );
  }

  FutureOr<void> _getAnnouncedMovies(
    GetAnnouncedMoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    emit(Loading());
    final errorOrMovies = await getAnnouncedMovies();
    errorOrMovies.fold(
          (error) => emit(Error(message: error.message)),
          (movies) => emit(Loaded(moviesList: movies)),
    );
  }
}
