import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/core/widgets/sc_nav_drawer.dart';
import 'package:south_cinema/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/repertoire_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/screenings_page_body.dart';
import 'package:south_cinema/injection_container.dart';

class ScreeningsPage extends StatelessWidget {
  const ScreeningsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      drawer: const SCNavDrawer(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => sl<RepertoireBloc>()
                ..add(GetRepertoireForDateEvent('15/03/2023'))),
          BlocProvider(
              create: (_) =>
                  sl<MoviesBloc>()..add(GetCurrentlyPlayedMoviesEvent())),
        ],
        child: const ScreeningsPageBody(),
      ),
    );
  }
}
