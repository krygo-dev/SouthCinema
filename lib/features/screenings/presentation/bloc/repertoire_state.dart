part of 'repertoire_bloc.dart';

abstract class RepertoireState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends RepertoireState {}

class Loading extends RepertoireState {}

class Loaded extends RepertoireState {
  final List<RepertoireScreening> repertoireList;

  Loaded({required this.repertoireList});

  @override
  List<Object> get props => [repertoireList];
}

class Error extends RepertoireState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}