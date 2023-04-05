part of 'repertoire_bloc.dart';

abstract class RepertoireState extends Equatable {
  @override
  List<Object> get props => [];
}

class RepertoireEmpty extends RepertoireState {}

class RepertoireLoading extends RepertoireState {}

class RepertoireLoaded extends RepertoireState {
  final List<RepertoireScreening> repertoireList;

  RepertoireLoaded({required this.repertoireList});

  @override
  List<Object> get props => [repertoireList];
}

class RepertoireError extends RepertoireState {
  final String message;

  RepertoireError({required this.message});

  @override
  List<Object> get props => [message];
}