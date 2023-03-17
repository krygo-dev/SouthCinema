part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends MoviesState {}

class Loading extends MoviesState {}

class Loaded extends MoviesState {
  final List<Movie> moviesList;

  Loaded({required this.moviesList});

  @override
  List<Object> get props => [moviesList];
}

class Error extends MoviesState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
