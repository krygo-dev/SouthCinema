part of 'screening_bloc.dart';

abstract class ScreeningEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetScreeningByIdEvent extends ScreeningEvent {
  final String id;

  GetScreeningByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}