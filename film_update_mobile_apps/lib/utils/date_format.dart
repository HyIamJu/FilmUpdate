import 'package:intl/intl.dart';

String formatDateMMMdyyyy(String dateStr) {
  DateTime date = DateTime.parse(dateStr);
  String formattedDate = DateFormat("MMM d, yyyy").format(date);
  return formattedDate;
}
