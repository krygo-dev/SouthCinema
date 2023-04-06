import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/repertoire_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_played_announced_row.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_repertoire_dates_row.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_repertoire_list_item.dart';
import 'package:south_cinema/injection_container.dart';

class ScreeningsPage extends StatelessWidget {
  const ScreeningsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => sl<RepertoireBloc>()
                ..add(GetRepertoireForDateEvent('15/03/2023'))),
          BlocProvider(create: (_) => sl<MoviesBloc>()),
        ],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SCRepertoireDatesRow(),
                // Repertoire container
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Container(
                    height: 525,
                    color: Theme.of(context).colorScheme.onBackground,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: BlocBuilder<RepertoireBloc, RepertoireState>(
                      builder: (context, state) {
                        if (state is RepertoireLoaded) {
                          return Column(
                            children: state.repertoireList.map((repertoire) {
                              return SCRepertoireListItem(repertoire: repertoire);
                            }).toList(),
                          );
                        } else if (state is RepertoireLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is RepertoireError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const Center(child: Text('Empty'));
                        }
                      },
                    ),
                  ),
                ),
                const SCPlayedAnnouncedRow(),
                Padding(
                  padding: const EdgeInsets.all(17),
                  child: Container(
                    color: Theme.of(context).colorScheme.onBackground,
                    child: Column(
                      children: [

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
