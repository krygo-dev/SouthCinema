import 'package:equatable/equatable.dart';

abstract class BaseError extends Equatable {
  final String message;

  const BaseError({required this.message});

  @override
  List<Object> get props => [];
}

class AuthError extends BaseError {
  const AuthError({required super.message});
}

class NetworkError extends BaseError {
  const NetworkError({super.message = "You don't have Internet connection."});
}