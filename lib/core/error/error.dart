import 'package:equatable/equatable.dart';

abstract class Error extends Equatable {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [];
}

class AuthError extends Error {
  AuthError({required super.message});
}

class NetworkError extends Error {
  NetworkError({super.message = "You don't have Internet connection."});
}