import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Purchase extends Equatable {
  final String id;
  final String screeningId;
  final String? userId;
  final String fullName;
  final Timestamp createdAt;
  final String phoneNumber;
  final String email;
  final Map<String, String> tickets;
  final double totalPrice;

  const Purchase({
    required this.id,
    required this.screeningId,
    this.userId,
    required this.fullName,
    required this.createdAt,
    required this.phoneNumber,
    required this.email,
    required this.tickets,
    required this.totalPrice,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      screeningId: json['screeningId'],
      userId: json['userId'],
      fullName: json['fullName'],
      createdAt: json['createdAt'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      tickets: (json['tickets']! as Map).cast<String, String>(),
      totalPrice: json['totalPrice'],
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
      'email': email,
      'tickets': tickets,
      'totalPrice': totalPrice,
    };
  }

  @override
  List<Object?> get props => [
        id,
        screeningId,
        userId,
        fullName,
        createdAt,
        phoneNumber,
        email,
        tickets,
        totalPrice,
      ];
}
