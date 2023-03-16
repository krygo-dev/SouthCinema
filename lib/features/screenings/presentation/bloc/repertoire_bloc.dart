import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';
import '../../domain/usecases/get_repertoire_for_date.dart';

part 'repertoire_event.dart';
part 'repertoire_state.dart';

class RepertoireBloc extends Bloc<RepertoireEvent, RepertoireState> {
  final GetRepertoireForDate getRepertoireForDate;

  RepertoireBloc({required this.getRepertoireForDate}) : super(Empty()) {
    on<GetRepertoireForDateEvent>(_onGetRepertoireForDate);
  }

  void _onGetRepertoireForDate(
    GetRepertoireForDateEvent event,
    Emitter<RepertoireState> emit,
  ) async {
    emit(Loading());
    final errorOrRepertoire =
        await getRepertoireForDate(date: event.dateString);
    errorOrRepertoire.fold(
      (error) => emit(Error(message: error.message)),
      (list) => emit(Loaded(repertoireList: list)),
    );
  }
}
