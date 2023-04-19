import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/presentation/pages/movie_page.dart';
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
    ],
  );
}
