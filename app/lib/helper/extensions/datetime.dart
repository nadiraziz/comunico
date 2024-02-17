import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String formattedDate() {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(this);
  }
}
