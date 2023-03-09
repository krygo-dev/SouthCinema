import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Screening extends Equatable {
  final String id;
  final Timestamp date;
  final String movieID;
  final String movieTitle;
  final String roomID;
  final bool reservationOn;
  final List<String> seatsTaken;

  const Screening({
    required this.id,
    required this.date,
    required this.movieID,
    required this.movieTitle,
    required this.roomID,
    required this.reservationOn,
    required this.seatsTaken,
  });

  factory Screening.fromJson(Map<String, Object> json) {
    return Screening(
      id: json['id']! as String,
      date: json['date']! as Timestamp,
      movieID: json['movieID']! as String,
      movieTitle: json['movieTitle']! as String,
      roomID: json['roomID']! as String,
      reservationOn: json['reservationOn']! as bool,
      seatsTaken: (json['seatsTaken']! as List).cast<String>(),
    );
  }

  @override
  List<Object?> get props =>
      [id, date, movieID, movieTitle, roomID, reservationOn, seatsTaken];
}
