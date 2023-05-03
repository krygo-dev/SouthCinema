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

class GettingDataError extends BaseError {
  const GettingDataError({super.message = 'Getting data was unsuccessful'});
}

class SettingDataError extends BaseError {
  const SettingDataError({super.message = 'Setting data was unsuccessful'});
}

class EmptyTextFieldError extends BaseError {
  const EmptyTextFieldError({
    super.message = 'Fields can\'t be empty. Please fill up all fields.',
  });
}
