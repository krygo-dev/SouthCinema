import 'package:flutter/material.dart';

class SCRoomTitleDate extends StatelessWidget {
  const SCRoomTitleDate({
    Key? key,
    required this.roomID,
    required this.movieTitle,
    required this.dateTime,
  }) : super(key: key);

  final String roomID;
  final String movieTitle;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/$roomID.png',
          height: 30,
          fit: BoxFit.cover,
        ),
        Text(
          movieTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          dateTime,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}