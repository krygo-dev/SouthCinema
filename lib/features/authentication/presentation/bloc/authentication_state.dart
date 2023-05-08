part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationEmpty extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationLoaded extends AuthenticationState {
  final AuthUser authUser;

  AuthenticationLoaded({required this.authUser});

  @override
  List<Object> get props => [authUser];
}

class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthenticationLoggedOut extends AuthenticationState {}