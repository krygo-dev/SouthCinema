import 'package:flutter/material.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/presentation/widgets/sc_movie_info_text_row.dart';
import 'package:south_cinema/features/movies/presentation/widgets/sc_movie_poster_title_desc_row.dart';
import 'package:south_cinema/features/movies/presentation/widgets/sc_youtube_video_player_container.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_played_announced_row.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SCPlayedAnnouncedRow(
              selected: movie.currentlyPlayed ? 0 : 1,
              onSelected: (int newValue) {}),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Container(
                color: Theme.of(context).colorScheme.onBackground,
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        SCMoviePosterTitleDescRow(movie: movie),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          children: [
                            SCMovieInfoTextRow(
                              infoTitle: 'Release date',
                              infoText: movie.premiereDate,
                            ),
                            SCMovieInfoTextRow(
                              infoTitle: 'Genre',
                              infoText: movie.genre
                                  .toString()
                                  .replaceAll(', ', '/')
                                  .replaceAll('[', '')
                                  .replaceAll(']', ''),
                            ),
                            SCMovieInfoTextRow(
                              infoTitle: 'Screening time',
                              infoText: '${movie.durationMin} min',
                            ),
                            SCMovieInfoTextRow(
                              infoTitle: 'Age restriction',
                              infoText: '${movie.ageRestriction}+',
                            ),
                            SCMovieInfoTextRow(
                              infoTitle: 'Format',
                              infoText: movie.format,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Column(
                          children: [
                            SCMovieInfoTextRow(
                              infoTitle: 'Director',
                              infoText: movie.director,
                            ),
                            SCMovieInfoTextRow(
                              infoTitle: 'Cast',
                              infoText: movie.cast
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', ''),
                            ),
                            SCMovieInfoTextRow(
                              infoTitle: 'Distribution',
                              infoText: movie.distribution,
                            ),
                            SCMovieInfoTextRow(
                              infoTitle: 'Production country',
                              infoText: movie.productionCountry,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          'assets/images/watch_trailer_here_text.png',
                          width: 170,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SCYoutubeVideoPlayerContainer(movie: movie),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
