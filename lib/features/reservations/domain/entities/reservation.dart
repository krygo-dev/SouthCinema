import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final String id;
  final String screeningId;
  final String userId;
  final Timestamp createdAt;
  final String phoneNumber;
  final List<String> seats;

  const Reservation({
    required this.id,
    required this.screeningId,
    required this.userId,
    required this.createdAt,
    required this.phoneNumber,
    required this.seats,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      screeningId: json['screeningId'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      phoneNumber: json['phoneNumber'],
      seats: json['seats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'screeningId': screeningId,
      'userId': userId,
      'createdAt': createdAt,
      'phoneNumber': phoneNumber,
      'seats': seats,
    };
  }

  @override
  List<Object?> get props =>
      [id, screeningId, userId, createdAt, phoneNumber, seats];
}
