import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String formattedDate() {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(this);
  }

  String formattedDateToServer() {
    final formatter = DateFormat('YYYY-MM-DD');

    return formatter.format(this);
  }
}

extension StringDateParsing on String {
  String formatDateString() {
    try {
      DateTime dateTime = DateFormat('dd MMM yyyy').parse(this);
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      return formattedDate;
    } catch (e) {
      // Handle invalid date format
      print('Invalid date format: $this');
      return '';
    }
  }
}
