import 'package:equatable/equatable.dart';

class RepertoireScreening extends Equatable {
  final String id;
  final String title;
  final String date;
  final List<Map<String, String>> screenings;

  const RepertoireScreening({
    required this.id,
    required this.title,
    required this.date,
    required this.screenings,
  });

  factory RepertoireScreening.fromJson(Map<String, Object> json) {
    return RepertoireScreening(
      id: json['id']! as String,
      title: json['title']! as String,
      date: json['date']! as String,
      screenings: (json['screenings']! as List).cast<Map<String, String>>(),
    );
  }

  @override
  List<Object?> get props => [id, title, date, screenings];
}
