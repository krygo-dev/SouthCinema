part of 'screening_bloc.dart';

abstract class ScreeningState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends ScreeningState {}

class Loading extends ScreeningState {}

class Loaded extends ScreeningState {
  final Screening screening;
  final Room room;

  Loaded({required this.screening, required this.room});

  @override
  List<Object> get props => [screening, room];
}

class Error extends ScreeningState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
