import 'ayah.dart';

// مدل سوره (Surah)
class Surah {
  final int number;
  final String name;
  final List<Ayah> ayahs;

  Surah({
    required this.number,
    required this.name,
    required this.ayahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    final ayahsJson = (json['ayahs'] as List<dynamic>?) ?? [];
    final ayahs = ayahsJson.map((a) => Ayah.fromJson(a as Map<String, dynamic>)).toList();
    return Surah(
      number: json['number'] as int,
      name: (json['name'] ?? '') as String,
      ayahs: ayahs,
    );
  }

  Map<String, dynamic> toJson() => {
        'number': number,
        'name': name,
        'ayahs': ayahs.map((a) => a.toJson()).toList(),
      };
}
