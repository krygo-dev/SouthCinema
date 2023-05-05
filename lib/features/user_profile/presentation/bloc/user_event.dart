part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserByIdEvent extends UserEvent {
  final String id;

  GetUserByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SetOrUpdateUserDataEvent extends UserEvent {
  final User user;

  SetOrUpdateUserDataEvent(this.user);

  @override
  List<Object> get props => [user];
}
