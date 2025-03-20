import 'package:intl/intl.dart';

class AppHelper {
  static String formatDate(String? inputDate) {
    if (inputDate == null) {
      return '';
    }
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formattedDate;
  }
}
