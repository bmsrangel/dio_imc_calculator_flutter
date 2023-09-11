import 'package:intl/intl.dart';

class DateFormatterUtil {
  static String ddMMyyyy(DateTime date) {
    final dateFormatter = DateFormat('dd/MM/yy');
    return dateFormatter.format(date);
  }
}
