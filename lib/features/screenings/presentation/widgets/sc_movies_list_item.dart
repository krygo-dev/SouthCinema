import 'package:flutter/material.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/presentation/pages/movie_page.dart';

class SCMovieListItem extends StatelessWidget {
  const SCMovieListItem({
    super.key,
    required this.movie,
    required this.reversed,
  });

  final Movie movie;
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    // List with widgets in row to allow items reversion
    List<Widget> widgetsList = [
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
    ];

    return InkWell(
      onTap: () {
        /// TEMPORARY ///
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MoviePage(movie: movie)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (!reversed) ...widgetsList else ...widgetsList.reversed.toList(),
          ],
        ),
      ),
    );
  }
}
