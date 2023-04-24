import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/presentation/pages/movie_page.dart';
import 'package:south_cinema/features/reservations/presentation/pages/buy_ticket_page.dart';
import 'package:south_cinema/features/reservations/presentation/pages/reservation_page.dart';
import 'package:south_cinema/features/screenings/presentation/pages/screening_page.dart';
import 'package:south_cinema/features/screenings/presentation/pages/screenings_page.dart';
import 'package:south_cinema/features/screenings/presentation/pages/splash_page.dart';

class NavigationRouter {
  get router => _router;

  final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        name: 'splash',
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: 'screenings',
        path: '/screenings',
        builder: (context, state) => const ScreeningsPage(),
      ),
      GoRoute(
        name: 'movie',
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
        name: 'screening',
        path: '/screening/:id',
        builder: (context, state) =>
            ScreeningPage(screeningId: state.params['id']!),
      ),
      GoRoute(
        name: 'reservation',
        path: '/reservation',
        builder: (context, state) => const ReservationPage(),
      ),
      GoRoute(
        name: 'buy_ticket',
        path: '/buy_ticket',
        builder: (context, state) => const BuyTicketPage(),
      ),
    ],
  );
}
