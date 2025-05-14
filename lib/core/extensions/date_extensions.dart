import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  String formatYMD() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  /// Format like e.g. 2025년 5월 14일 수요일
  String formatFull() {
    return DateFormat.yMMMMEEEEd('ko_KR').format(this);
  }
}
