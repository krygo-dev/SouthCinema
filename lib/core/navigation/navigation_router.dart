import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:south_cinema/core/navigation/reservation_purchase_page_arguments.dart';
import 'package:south_cinema/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:south_cinema/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/presentation/pages/movie_page.dart';
import 'package:south_cinema/features/reservations/presentation/pages/purchase_page.dart';
import 'package:south_cinema/features/reservations/presentation/pages/reservation_page.dart';
import 'package:south_cinema/features/reservations/presentation/pages/user_purchased_tickets_page.dart';
import 'package:south_cinema/features/reservations/presentation/pages/user_reservations_page.dart';
import 'package:south_cinema/features/screenings/presentation/pages/screening_page.dart';
import 'package:south_cinema/features/screenings/presentation/pages/screenings_page.dart';
import 'package:south_cinema/features/screenings/presentation/pages/splash_page.dart';
import 'package:south_cinema/features/user_profile/presentation/pages/user_profile_page.dart';

abstract class Routes {
  static String splash = 'splash';
  static String screenings = 'screenings';
  static String movie = 'movie';
  static String screening = 'screening';
  static String reservation = 'reservation';
  static String purchase = 'purchase';
  static String signIn = 'sign_in';
  static String signUp = 'sign_up';
  static String userProfile = 'user_profile';
  static String userReservations = 'user_reservations';
  static String userPurchasedTickets = 'user_purchased_tickets';
}

class NavigationRouter {
  static const String _initialLocation = '/splash';

  get router => _router;

  final GoRouter _router = GoRouter(
    initialLocation: _initialLocation,
    routes: [
      GoRoute(
        name: Routes.splash,
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: Routes.screenings,
        path: '/screenings',
        builder: (context, state) => const ScreeningsPage(),
      ),
      GoRoute(
        name: Routes.movie,
        path: '/movie',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: MoviePage(movie: state.extra as Movie),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          maintainState: true,
        ),
      ),
      GoRoute(
        name: Routes.screening,
        path: '/screening/:id',
        builder: (context, state) =>
            ScreeningPage(screeningId: state.params['id']!),
      ),
      GoRoute(
        name: Routes.reservation,
        path: '/reservation',
        builder: (context, state) => ReservationPage(
          arguments: state.extra as ReservationPurchasePageArguments,
        ),
      ),
      GoRoute(
        name: Routes.purchase,
        path: '/purchase',
        builder: (context, state) => PurchasePage(
          arguments: state.extra as ReservationPurchasePageArguments,
        ),
      ),
      GoRoute(
        name: Routes.signIn,
        path: '/sign_in',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        name: Routes.signUp,
        path: '/sign_up',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        name: Routes.userProfile,
        path: '/user_profile/:uid',
        builder: (context, state) => UserProfilePage(uid: state.params['uid']!),
      ),
      GoRoute(
        name: Routes.userReservations,
        path: '/user_reservations/:uid',
        builder: (context, state) => UserReservationsPage(uid: state.params['uid']!),
      ),
      GoRoute(
        name: Routes.userPurchasedTickets,
        path: '/user_purchased_tickets/:uid',
        builder: (context, state) => UserPurchasedTicketsPage(uid: state.params['uid']!),
      ),
    ],
  );
}
