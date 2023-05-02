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
import 'package:south_cinema/features/reservations/data/datasources/purchase_service.dart';
import 'package:south_cinema/features/reservations/data/datasources/purchase_service_impl.dart';
import 'package:south_cinema/features/reservations/data/datasources/reservations_service.dart';
import 'package:south_cinema/features/reservations/data/datasources/reservations_service_impl.dart';
import 'package:south_cinema/features/reservations/data/repositories/reservations_repository_impl.dart';
import 'package:south_cinema/features/reservations/domain/repositories/reservations_repository.dart';
import 'package:south_cinema/features/reservations/domain/usecases/create_new_purchase.dart';
import 'package:south_cinema/features/reservations/domain/usecases/create_new_reservation.dart';
import 'package:south_cinema/features/reservations/domain/usecases/get_user_purchased_tickets.dart';
import 'package:south_cinema/features/reservations/domain/usecases/get_user_reservations.dart';
import 'package:south_cinema/features/reservations/presentation/bloc/purchase_bloc.dart';
import 'package:south_cinema/features/reservations/presentation/bloc/reservation_bloc.dart';
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

  /// Features - Reservations/Purchases ///
  //Bloc
  sl.registerFactory(() => PurchaseBloc(createNewPurchase: sl()));
  sl.registerFactory(() => ReservationBloc(createNewReservation: sl()));
  // Use cases
  sl.registerLazySingleton(() => CreateNewPurchase(sl()));
  sl.registerLazySingleton(() => GetUserPurchasedTickets(sl()));
  sl.registerLazySingleton(() => CreateNewReservation(sl()));
  sl.registerLazySingleton(() => GetUserReservations(sl()));
  // Repository
  sl.registerLazySingleton<ReservationsRepository>(
    () => ReservationsRepositoryImpl(
      reservationService: sl(),
      purchaseService: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<ReservationService>(
      () => ReservationsServiceImpl(sl(), sl()));
  sl.registerLazySingleton<PurchaseService>(
    () => PurchaseServiceImpl(sl(), sl()),
  );

  /// Features - User_profile ///

  /// Core ///
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External ///
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
