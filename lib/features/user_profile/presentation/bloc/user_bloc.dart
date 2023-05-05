import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';
import 'package:south_cinema/features/user_profile/domain/usecases/get_user_by_id.dart';
import 'package:south_cinema/features/user_profile/domain/usecases/set_or_update_user_data.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserById getUserById;
  final SetOrUpdateUserData setOrUpdateUserData;

  UserBloc({
    required this.getUserById,
    required this.setOrUpdateUserData,
  }) : super(UserEmpty()) {
    on<GetUserByIdEvent>(_getUserById);
    on<SetOrUpdateUserDataEvent>(_setOrUpdateUserData);
  }

  FutureOr<void> _getUserById(
    GetUserByIdEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final errorOrUser = await getUserById(uid: event.id);
    errorOrUser.fold(
      (error) => emit(UserError(message: error.message)),
      (user) => emit(UserLoaded(user: user)),
    );
  }

  FutureOr<void> _setOrUpdateUserData(
    SetOrUpdateUserDataEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final errorOrSuccess = await setOrUpdateUserData(user: event.user);

    await errorOrSuccess.fold(
      (error) async => emit(UserError(message: error.message)),
      (success) async => add(GetUserByIdEvent(event.user.uid))
    );
  }
}
