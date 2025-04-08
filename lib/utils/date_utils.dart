import 'package:intl/intl.dart';

class DateUtilsHelper {
  static String format(DateTime? date, {String pattern = 'yyyy-MM-dd'}) {
    if (date == null) return '';
    return DateFormat(pattern).format(date);
  }
}
