import 'package:intl/intl.dart';

class DecimalFormatterUtil {
  static String format(double value, {int decimalDigits = 1}) {
    final numberFormat = NumberFormat.decimalPatternDigits(
      decimalDigits: decimalDigits,
      locale: 'pt_BR',
    );
    return numberFormat.format(value);
  }
}
