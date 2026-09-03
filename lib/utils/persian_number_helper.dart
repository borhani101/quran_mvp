// lib/utils/persian_number_helper.dart

class PersianNumberHelper {
  static const List<String> _persianDigits = [
    '۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'
  ];

  /// تبدیل عدد یا رشته حاوی عدد به ارقام فارسی
  static String toPersian(dynamic input) {
    if (input == null) return '';
    final str = input.toString();
    var result = '';
    for (var char in str.codeUnits) {
      if (char >= 48 && char <= 57) {
        result += _persianDigits[char - 48];
      } else {
        result += String.fromCharCode(char);
      }
    }
    return result;
  }

  /// قالب‌بندی نشان انتهای آیه قرآنی به شکل ﴿ ۱ ﴾
  static String getAyahEndSymbol(int ayahNumber) {
    return ' ﴿${toPersian(ayahNumber)}﴾ ';
  }
}
