// مدل آیه (Ayah)
class Ayah {
  final int number;
  final String textAr;
  final String textFa;

  Ayah({
    required this.number,
    required this.textAr,
    required this.textFa,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['number'] as int,
      textAr: (json['text_ar'] ?? '') as String,
      textFa: (json['text_fa'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'number': number,
        'text_ar': textAr,
        'text_fa': textFa,
      };
}
