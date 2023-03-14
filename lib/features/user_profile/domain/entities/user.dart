import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String city;
  final String postCode;
  final String street;
  final String contactNumber;

  const User({
    required this.uid,
    required this.email,
    required this.name,
    required this.city,
    required this.postCode,
    required this.street,
    required this.contactNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      city: json['city'],
      postCode: json['postCode'],
      street: json['street'],
      contactNumber: json['contactNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'city': city,
      'postCode': postCode,
      'street': street,
      'contactNumber': contactNumber,
    };
  }

  @override
  List<Object?> get props =>
      [uid, email, name, city, postCode, street, contactNumber];
}
