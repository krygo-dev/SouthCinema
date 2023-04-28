import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final String id;
  final String screeningId;
  final String? userId;
  final String fullName;
  final Timestamp createdAt;
  final String phoneNumber;
  final List<String> seats;

  const Reservation({
    required this.id,
    required this.screeningId,
    this.userId,
    required this.fullName,
    required this.createdAt,
    required this.phoneNumber,
    required this.seats,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      screeningId: json['screeningId'],
      userId: json['userId'],
      fullName: json['fullName'],
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
      'fullName': fullName,
      'createdAt': createdAt,
      'phoneNumber': phoneNumber,
      'seats': seats,
    };
  }

  @override
  List<Object?> get props =>
      [id, screeningId, userId, fullName, createdAt, phoneNumber, seats];
}
