import 'package:flutter/cupertino.dart';
import 'package:south_cinema/features/screenings/domain/entities/room.dart';
import 'package:south_cinema/features/screenings/domain/entities/screening.dart';

class ReservationPurchasePageArguments {
  ReservationPurchasePageArguments({
    Key? key,
    required this.room,
    required this.screening,
    required this.dateTimeStr,
    required this.chosenSeats,
  });

  final Room room;
  final Screening screening;
  final String dateTimeStr;
  final List<String> chosenSeats;
}
