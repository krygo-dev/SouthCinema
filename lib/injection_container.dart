import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:south_cinema/core/network/network_info.dart';
import 'package:south_cinema/features/movies/data/datasources/movies_service.dart';
import 'package:south_cinema/features/movies/data/datasources/movies_service_impl.dart';
import 'package:south_cinema/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:south_cinema/features/movies/domain/repositories/movies_repository.dart';
import 'package:south_cinema/features/movies/domain/usecases/get_announced_movies.dart';
import 'package:south_cinema/features/movies/domain/usecases/get_currently_played_movies.dart';
import 'package:south_cinema/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:south_cinema/features/screenings/data/datasources/screenings_service.dart';
import 'package:south_cinema/features/screenings/data/datasources/screenings_service_impl.dart';
import 'package:south_cinema/features/screenings/data/repositories/screenings_repository_impl.dart';
import 'package:south_cinema/features/screenings/domain/repositories/screenings_repository.dart';
import 'package:south_cinema/features/screenings/domain/usecases/get_repertoire_for_date.dart';
import 'package:south_cinema/features/screenings/domain/usecases/get_room_by_id.dart';
import 'package:south_cinema/features/screenings/domain/usecases/get_screening_by_id.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/repertoire_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/screening_bloc.dart';

final sl = GetIt.instance;

void init() {
  /// Features - Screenings ///
  // Bloc
  sl.registerFactory(() => RepertoireBloc(getRepertoireForDate: sl()));
  sl.registerFactory(
    () => ScreeningBloc(getScreeningById: sl(), getRoomById: sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetRepertoireForDate(sl()));
  sl.registerLazySingleton(() => GetScreeningById(sl()));
  sl.registerLazySingleton(() => GetRoomById(sl()));
  // Repository
  sl.registerLazySingleton<ScreeningsRepository>(
    () => ScreeningsRepositoryImpl(
      screeningsService: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<ScreeningsService>(
    () => ScreeningsServiceImpl(sl()),
  );

  /// Features - Movies ///
  // Bloc
  sl.registerFactory(
    () => MoviesBloc(getCurrentlyPlayedMovies: sl(), getAnnouncedMovies: sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetCurrentlyPlayedMovies(sl()));
  sl.registerLazySingleton(() => GetAnnouncedMovies(sl()));
  // Repository
  sl.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(moviesService: sl(), networkInfo: sl()),
  );
  // Data sources
  sl.registerLazySingleton<MoviesService>(() => MoviesServiceImpl(sl()));

  /// Features - Authentication ///
  /// Features - Reservations ///
  /// Features - User_profile ///

  /// Core ///
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External ///
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
