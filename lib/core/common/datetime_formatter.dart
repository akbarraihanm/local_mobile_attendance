import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const String defaultDateFormat = "yyyy-MM-dd kk:mm";

abstract class DateTimeFormatter {
  static String formatTime({
    String dateFormat = defaultDateFormat,
    DateTime? dateTime
  }) {
    initializeDateFormatting();
    return DateFormat(dateFormat, 'id').format(
        dateTime ?? DateTime.parse("2000-01-01 00:00:00"));
  }
}