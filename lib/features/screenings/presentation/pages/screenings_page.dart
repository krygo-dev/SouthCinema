import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/repertoire_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_repertoire_dates_row.dart';
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
          child: Column(
            children: [
              const SCRepertoireDatesRow(),
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Container(
                  color: Theme.of(context).colorScheme.onBackground,
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: BlocBuilder<RepertoireBloc, RepertoireState>(
                    builder: (context, state) {
                      if (state is RepertoireLoaded) {
                        print(state.repertoireList);
                        return Column(
                          children: state.repertoireList.map((repertoire) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        repertoire.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                        repertoire.screenings.map((screening) {
                                      return Container(
                                        width: 41,
                                        height: 24,
                                        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                                        alignment: Alignment.center,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        child: Text(
                                          screening['time'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      } else if (state is RepertoireLoading) {
                        print('Repertoire loading');
                        return const CircularProgressIndicator();
                      } else if (state is RepertoireError) {
                        return Text(state.message);
                      } else {
                        return const Text('Empty');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
