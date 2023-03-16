part of 'repertoire_bloc.dart';

abstract class RepertoireEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRepertoireForDateEvent extends RepertoireEvent {
  final String dateString;

  GetRepertoireForDateEvent(this.dateString);

  @override
  List<Object> get props => [dateString];
}