part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCurrentUserEvent extends AuthenticationEvent {}

class SignInWithEmailAndPasswordEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SignInWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignUpWithEmailAndPasswordEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String repeatPassword;

  SignUpWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
    required this.repeatPassword,
  });

  @override
  List<Object> get props => [email, password, repeatPassword];
}

class SignOutEvent extends AuthenticationEvent {}
