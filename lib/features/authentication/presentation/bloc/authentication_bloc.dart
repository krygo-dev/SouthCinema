import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';
import 'package:south_cinema/features/authentication/domain/usecases/get_current_user.dart';
import 'package:south_cinema/features/authentication/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:south_cinema/features/authentication/domain/usecases/sign_out.dart';
import 'package:south_cinema/features/authentication/domain/usecases/sign_up_with_email_and_password.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetCurrentUser getCurrentUser;
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignUpWithEmailAndPassword signUpWithEmailAndPassword;
  final SignOut signOut;

  AuthenticationBloc({
    required this.getCurrentUser,
    required this.signInWithEmailAndPassword,
    required this.signUpWithEmailAndPassword,
    required this.signOut,
  }) : super(AuthenticationEmpty()) {
    on<GetCurrentUserEvent>(_getCurrentUser);
    on<SignInWithEmailAndPasswordEvent>(_signIn);
    on<SignUpWithEmailAndPasswordEvent>(_signUp);
    on<SignOutEvent>(_signOut);
  }

  FutureOr<void> _getCurrentUser(
    GetCurrentUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    final currentUser = getCurrentUser.call;

    if (currentUser == null) {
      emit(AuthenticationLoggedOut());
    } else {
      emit(AuthenticationLoaded(authUser: currentUser));
    }
  }

  FutureOr<void> _signIn(
    SignInWithEmailAndPasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());

    final errorOrAuthUser = await signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    errorOrAuthUser.fold(
      (error) => emit(AuthenticationError(message: error.message)),
      (authUser) => emit(AuthenticationLoaded(authUser: authUser)),
    );
  }

  FutureOr<void> _signUp(
    SignUpWithEmailAndPasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());

    final errorOrAuthUser = await signUpWithEmailAndPassword(
      email: event.email,
      password: event.password,
      repeatPassword: event.repeatPassword,
    );

    errorOrAuthUser.fold(
      (error) => emit(AuthenticationError(message: error.message)),
      (authUser) => emit(AuthenticationLoaded(authUser: authUser)),
    );
  }

  FutureOr<void> _signOut(
    SignOutEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    final errorOrResult = await signOut();

    errorOrResult.fold(
      (error) => emit(AuthenticationError(message: error.message)),
      (result) => emit(AuthenticationLoggedOut()),
    );
  }
}
