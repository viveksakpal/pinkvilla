import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utility {
  static String convertTimeStampToDate(int timestamp) {
    print(timestamp.toString() + " ye ");
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
    var day = NumberFormat("00").format(date.day);
    var month = NumberFormat("00").format(date.month);
    var year = date.year;
    return "$day-$month-$year";
  }

  static String convertTimeStampToSimplyDate(int timestamp) {
    print(timestamp.toString() + " ye ");
    DateTime date =
    DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    var formatter = new DateFormat('yyyyMMdd');
    String formattedDate = formatter.format(date);

    return formattedDate;
  }

  static String formatDateForChatListing(String value) {
    var formatter = new DateFormat('dd-MMM-yyyy');
    DateTime dateTime = DateTime.parse(value);

    String currentDateTime = formatter.format(DateTime.now());

    String formattedDate = formatter.format(dateTime);

    if (currentDateTime == formattedDate) {
      return "Today";
    }

    return formattedDate;
  }

  static String convertTimeStampToTime(int timestamp) {
//    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
    DateTime date =
    DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: false);
    int hour = date.hour;
    String minute = formatMinutes(date.minute);

    return "$hour:$minute ";
  }

  static String differenceBetween2tTimestamp(int t1, int t2) {
    var d1 = DateTime.fromMillisecondsSinceEpoch(t1, isUtc: true);
    var d2 = DateTime.fromMillisecondsSinceEpoch(t2, isUtc: true);
    int diff;
    diff = d1.difference(d2).inDays;
    print("diff   $diff");
    if (diff % 365 == 0) {
      return (diff / 365).toString().substring(0, 3) + " years";
    } else {
      return (diff / 30).toString().substring(0, 3) + " months";
    }
  }

  static bool differenceBetweenDate(int t1, int t2) {
    bool isAfter;
    try {
      DateTime date1 =
      DateTime.fromMillisecondsSinceEpoch(t1 * 1000, isUtc: false);
      DateTime date2 =
      DateTime.fromMillisecondsSinceEpoch(t2 * 1000, isUtc: false);

      String date1String =
          date1.day.toString() + date1.month.toString() + date1.year.toString();

      isAfter = date1.isAfter(date2);

      print("Date1String " + date1String.toString());

    } on Exception {}

    return isAfter;
  }

  static hexToColor(String code) {
    return Color(int.parse("0x$code"));
  }

  static Future<String> getAppVersion() async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // return packageInfo.version;
  }


  static String formatMinutes(int minute) {
    if (minute.toString().length >= 2) {
      return minute.toString();
    } else {
      return "0" + minute.toString();
    }
  }
}
