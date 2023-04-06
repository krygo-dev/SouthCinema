import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
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
          BlocProvider(
              create: (_) =>
                  sl<MoviesBloc>()..add(GetCurrentlyPlayedMoviesEvent())),
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
                              return SCRepertoireListItem(
                                  repertoire: repertoire);
                            }).toList(),
                          );
                        } else if (state is RepertoireLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 12),
                    child: BlocBuilder<MoviesBloc, MoviesState>(
                      builder: (context, state) {
                        if (state is MoviesLoaded) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.moviesList.length,
                            itemBuilder: (context, index) {
                              Movie movie = state.moviesList[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      movie.posterUrl,
                                      width: 170,
                                      height: 258,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 17,),
                                    SizedBox(
                                      width: 137,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            movie.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 3,),
                                          Text(
                                            movie.description,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                          // return Column(
                          //   children: state.moviesList.map((movie) {
                          //     return Padding(
                          //       padding: const EdgeInsets.only(bottom: 20),
                          //       child: Row(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Image.network(
                          //             movie.posterUrl,
                          //             width: 170,
                          //             height: 258,
                          //             fit: BoxFit.cover,
                          //           ),
                          //           const SizedBox(width: 17,),
                          //           SizedBox(
                          //             width: 137,
                          //             child: Column(
                          //               mainAxisAlignment: MainAxisAlignment.start,
                          //               crossAxisAlignment: CrossAxisAlignment.start,
                          //               children: [
                          //                 Text(
                          //                   movie.title,
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .titleMedium,
                          //                   textAlign: TextAlign.start,
                          //                   overflow: TextOverflow.ellipsis,
                          //                 ),
                          //                 const SizedBox(height: 3,),
                          //                 Text(
                          //                   movie.description,
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .bodySmall,
                          //                   textAlign: TextAlign.start,
                          //                 ),
                          //               ],
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     );
                          //   }).toList(),
                          // );
                        } else if (state is MoviesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is MoviesError) {
                          return Center(
                            child: Text(state.message),
                          );
                        } else {
                          return const Center(
                            child: Text('Empty'),
                          );
                        }
                      },
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
