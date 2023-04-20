import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String id;
  final String name;
  // final int rows;
  // final int rowsLength;
  final List<int> seatsConfiguration;

  const Room({
    required this.id,
    required this.name,
    required this.seatsConfiguration,
    // required this.rows,
    // required this.rowsLength,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id']! as String,
      name: json['name']! as String,
      seatsConfiguration: (json['seatsConfiguration']! as List).cast<int>()
      // rows: json['rows']! as int,
      // rowsLength: json['rowsLength']! as int,
    );
  }

  // @override
  // List<Object?> get props => [id, name, rows, rowsLength];
  @override
  List<Object?> get props => [id, name, seatsConfiguration];
}
