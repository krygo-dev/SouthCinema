import 'package:flutter_test/flutter_test.dart';
import 'package:south_cinema/features/screenings/domain/entities/room.dart';

void main() {
  test('should return valid Room entity from json', () {
    // arrange
    const tRoom = Room(id: 'room_1', name: 'Room 1', rows: 10, rowsLength: 10);
    const tJson = <String, Object>{
      'id': 'room_1',
      'name': 'Room 1',
      'rows': 10,
      'rowsLength': 10
    };
    // act
    final result = Room.fromJson(tJson);
    // assert
    expect(result, tRoom);
  });
}
