part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviesEmpty extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> moviesList;

  MoviesLoaded({required this.moviesList});

  @override
  List<Object> get props => [moviesList];
}

class MoviesError extends MoviesState {
  final String message;

  MoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
