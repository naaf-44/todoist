import 'package:intl/intl.dart';

class DateTimeExtension{
  static String listTileDateFormat(String date){
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return formattedDate;
  }

}