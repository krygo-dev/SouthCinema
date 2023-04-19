import 'package:flutter/material.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';

class SCMoviePosterTitleDescRow extends StatelessWidget {
  const SCMoviePosterTitleDescRow({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                style:
                Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                movie.description,
                style:
                Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}