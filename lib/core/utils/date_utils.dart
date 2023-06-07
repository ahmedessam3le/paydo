import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paydo/core/const/app_strings.dart';

class Month {
  static const int january = 1;
  static const int february = 2;
  static const int march = 3;
  static const int april = 4;
  static const int may = 5;
  static const int june = 6;
  static const int july = 7;
  static const int august = 8;
  static const int september = 9;
  static const int october = 10;
  static const int november = 11;
  static const int december = 12;
}

class DateUtils {
  static DateTime? dateFromMilliseconds(final int? timestamp) {
    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    } else {
      return null;
    }
  }

  static int? getMillisecondsSinceEpochDateTime(final DateTime date) {
    try {
      return date.millisecondsSinceEpoch;
    } catch (e) {
      return null;
    }
  }

  static bool isTheSameDay({
    required final int? firstDate,
    required final int? secondDate,
  }) {
    if (firstDate != null && secondDate != null) {
      final DateTime firstDateTime = dateFromMilliseconds(firstDate)!;
      final DateTime secondDateTime = dateFromMilliseconds(secondDate)!;
      return firstDateTime.year == secondDateTime.year &&
          firstDateTime.month == secondDateTime.month &&
          firstDateTime.day == secondDateTime.day;
    } else {
      return false;
    }
  }

  static String getDateYT(final int? date) {
    if (date != null) {
      final DateTime dateTime = dateFromMilliseconds(date)!;
      final DateTime now = DateTime.now();
      final DateTime yesterday = now.subtract(const Duration(days: 1));
      if (isTheSameDay(
        firstDate: getMillisecondsSinceEpochDateTime(now),
        secondDate: date,
      )) {
        return AppStrings.today.tr;
      } else if (dateTime.difference(yesterday).inDays == 0) {
        return AppStrings.yesterday.tr;
      } else {
        return getDateFormat(date);
      }
    } else {
      return '';
    }
  }

  static String dateCheckZero(final int v) {
    final String e = v.toString();
    if (e.length == 1) {
      return '0$e';
    } else {
      return e;
    }
  }

  static String getDateFormat(final int? timestamp,
      {final bool fullDate = false}) {
    String res = '';
    if (timestamp != null) {
      final DateTime date = dateFromMilliseconds(timestamp)!;
      if (fullDate) {
        return '${dateCheckZero(date.day)} ${getMonth(date)} ${date.year} ${getTimeAMPM(date)}';
      } else {
        return '${dateCheckZero(date.day)}${getMonth(date)} ${date.year}';
      }
    }
    return res;
  }

  static String getTimeAMPM(final DateTime v) {
    final DateTime tempDate = DateFormat.Hms().parse(
      '${v.hour}:${v.minute}:0:0',
    );
    final DateFormat dateFormat = DateFormat('hh:mm a');
    return (dateFormat.format(tempDate)).toLowerCase();
  }

  static String getMonth(final DateTime date, {final bool fullName = true}) {
    switch (date.month) {
      case Month.january:
        return fullName ? AppStrings.january.tr : AppStrings.jan.tr;
      case Month.february:
        return fullName ? AppStrings.february.tr : AppStrings.feb.tr;
      case Month.march:
        return fullName ? AppStrings.march.tr : AppStrings.mar.tr;
      case Month.april:
        return fullName ? AppStrings.april.tr : AppStrings.apr.tr;
      case Month.may:
        return fullName ? AppStrings.mayFull.tr : AppStrings.may.tr;
      case Month.june:
        return fullName ? AppStrings.june.tr : AppStrings.jun.tr;
      case Month.july:
        return fullName ? AppStrings.july.tr : AppStrings.jul.tr;
      case Month.august:
        return fullName ? AppStrings.august.tr : AppStrings.aug.tr;
      case Month.september:
        return fullName ? AppStrings.september.tr : AppStrings.sept.tr;
      case Month.october:
        return fullName ? AppStrings.october.tr : AppStrings.oct.tr;
      case Month.november:
        return fullName ? AppStrings.november.tr : AppStrings.nov.tr;
      case Month.december:
        return fullName ? AppStrings.december.tr : AppStrings.dec.tr;
      default:
        return '';
    }
  }
}
