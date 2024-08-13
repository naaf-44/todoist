import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todoist/models/hive_model.dart';

class DateTimeExtension{
  static String listTileDateFormat(String date){
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    return formattedDate;
  }

  static String getTotalTime(String id, Box<HiveModel> hiveModelBox) {
    for (var val in hiveModelBox.values) {
      if (val.id == id) {
        DateTime dateTime1 = DateTime.parse(val.startDate!);
        DateTime dateTime2 = DateTime.parse(val.endDate!);

        Duration difference = dateTime2.difference(dateTime1);

        if (difference.inDays > 1) {
          return DateFormat('dd MMM yyyy').format(dateTime1);
        } else if (difference.inDays == 1) {
          return DateFormat('HH:mm').format(dateTime1);
        } else if (difference.inHours >= 1) {
          return '${difference.inHours} hour(s)';
        } else if (difference.inMinutes >= 1) {
          return '${difference.inMinutes} minute(s)';
        } else {
          return 'Less than a minute';
        }
      }
    }
    return "";
  }
}