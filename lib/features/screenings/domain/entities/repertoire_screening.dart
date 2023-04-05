import 'package:equatable/equatable.dart';

class RepertoireScreening extends Equatable {
  final String id;
  final String title;
  final String date;
  final List<Map<String, dynamic>> screenings;

  const RepertoireScreening({
    required this.id,
    required this.title,
    required this.date,
    required this.screenings,
  });

  factory RepertoireScreening.fromJson(Map<String, dynamic> json) {
    return RepertoireScreening(
      id: json['id']! as String,
      title: json['title']! as String,
      date: json['date']! as String,
      screenings: (json['screenings']! as List).cast<Map<String, dynamic>>(),
    );
  }

  @override
  List<Object?> get props => [id, title, date, screenings];
}

const toDb = [
  RepertoireScreening(
    id: 'cMvGHisgTHqdxB8rMMm9',
    title: 'Creed III',
    date: '15/03/2023',
    screenings: [
      {
        'screeningID': 'MeinUgFzpPjMOiD0s1Zk',
        'time': '15:00',
      },
      {
        'screeningID': 'sC6itE6LOc5wKRPftUDm',
        'time': '17:30',
      },
      {
        'screeningID': 'b5wOHT00735SIsXeI5MV',
        'time': '19:00',
      },
      {
        'screeningID': '4mKgeuHcBrRz2AOLxgBf',
        'time': '22:00',
      },
    ],
  ),
  RepertoireScreening(
    id: '17oFCpmcD6k8eXl9J2jr',
    title: 'Shazam! Fury of the Gods',
    date: '15/03/2023',
    screenings: [
      {
        'screeningID': 'cCbtcacg0zpfuJOrqYMx',
        'time': '13:00',
      },
      {
        'screeningID': 'O6vBaMQGIwx8c2AnGNG4',
        'time': '16:00',
      },
      {
        'screeningID': 'IltKNWcYTcX2wkIfzmem',
        'time': '18:00',
      },
    ],
  ),
  RepertoireScreening(
    id: 'XjiEsaMn2LmyXE6TfpHp',
    title: 'Ant-Man and the Wasp: Quantumania',
    date: '15/03/2023',
    screenings: [
      {
        'screeningID': 'vRZBr9RD7qfwWDnlAMPl',
        'time': '15:30',
      },
      {
        'screeningID': 'cYOeOGhAPLanlADQ99mG',
        'time': '18:00',
      },
      {
        'screeningID': 'OjTbOkiwSSmZ6DgF0mnD',
        'time': '21:00',
      },
    ],
  ),
  RepertoireScreening(
    id: 'cefXpYlz69ZQkBaOTFmB',
    title: 'Ant-Man and the Wasp: Quantumania',
    date: '15/03/2023',
    screenings: [
      {
        'screeningID': 'xFIr8rrXsGnmsat6l8ly',
        'time': '11:00',
      },
      {
        'screeningID': 'OpeR4deDmLYcHwXfr44Z',
        'time': '12:00',
      },
      {
        'screeningID': 'jH8KtoCAADEZrYyfqQhk',
        'time': '13:00',
      },
      {
        'screeningID': 'xMHqs7K0REuQ2zwBHgkM',
        'time': '14:30',
      },
      {
        'screeningID': 'c3iT0twPfHTt08JBVuBv',
        'time': '16:00',
      },
    ],
  ),
  RepertoireScreening(
    id: 'YWJGZhTmSgWC5oNGbpXF',
    title: "Magic Mike's Last Dance",
    date: '15/03/2023',
    screenings: [
      {
        'screeningID': 'cXeCCKE8LxQ2ywnq7ZNH',
        'time': '18:00',
      },
      {
        'screeningID': '6A5j20fhd1f5KpmoQcf4',
        'time': '20:00',
      },
      {
        'screeningID': 'AtDoF8KMlIorFjfkdlZ5',
        'time': '21:15',
      },
    ],
  ),
  RepertoireScreening(
    id: 'iXjNTWCY1nLL4nm2oL8I',
    title: "The Whale",
    date: '15/03/2023',
    screenings: [
      {
        'screeningID': 'SIlYyfROasCoQ4kFE1Bq',
        'time': '15:00',
      },
      {
        'screeningID': 'clSCMKf8WBjBm9Hfmn7s',
        'time': '21:00',
      },
    ],
  ),
  RepertoireScreening(
    id: 'ZaoyvkZhvoJ19bW6CzCp',
    title: "John Wick: Chapter 4",
    date: '15/03/2023',
    screenings: [
      {
        'screeningID': '4mj2a9yJf29DRwBmPbCj',
        'time': '14:30',
      },
      {
        'screeningID': '6FyYLHxz0yBlwaNobAvE',
        'time': '16:00',
      },
      {
        'screeningID': 'PWV7OqrmUunravgTfhsn',
        'time': '22:00',
      },
    ],
  ),
];
