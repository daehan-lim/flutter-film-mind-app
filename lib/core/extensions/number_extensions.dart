import 'package:intl/intl.dart';

extension NumberFormatting on num {
  String formatCurrency({int decimalDigits = 0}) {
    return NumberFormat.simpleCurrency(
      locale: 'en_US',
      decimalDigits: decimalDigits,
    ).format(this);
  }

  String formatDecimal({int decimalDigits = 1}) {
    final format = NumberFormat.decimalPattern()
      ..minimumFractionDigits = decimalDigits
      ..maximumFractionDigits = decimalDigits;
    return format.format(this);
  }
}
