import 'package:flutter/material.dart';

class SCMovieInfoTextRow extends StatelessWidget {
  const SCMovieInfoTextRow({
    super.key,
    required this.infoTitle,
    required this.infoText,
  });

  final String infoTitle;
  final String infoText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Text(
            '$infoTitle: ',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Text(
            infoText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}