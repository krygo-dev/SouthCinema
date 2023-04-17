import 'package:flutter/material.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/presentation/widgets/sc_movie_info_text_row.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_played_announced_row.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      body: Column(
        children: [
          SCPlayedAnnouncedRow(selected: 1, onSelected: (int newValue) {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
              color: Theme.of(context).colorScheme.onBackground,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          movie.posterUrl,
                          width: 170,
                          height: 258,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        SizedBox(
                          width: 137,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                movie.description,
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                    Image.asset(
                      'assets/images/watch_trailer_here_text.png',
                      width: 170,
                      height: 258,
                      fit: BoxFit.cover,
                    ),
                    Container(width: 70, height: 100, child: Placeholder()),
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
