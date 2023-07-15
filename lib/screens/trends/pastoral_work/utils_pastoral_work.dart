import 'package:intl/intl.dart';

int numberOfDaysBetweenDates(DateTime startDate, DateTime endDate) {
  return endDate.difference(startDate).inDays;
}

int numberOfWeeksBetweenDates(DateTime startDate, DateTime endDate) {
  return endDate.difference(startDate).inDays ~/ 7;
}

int numberOfMonthsBetweenDates(DateTime startDate, DateTime endDate) {
  return (endDate.year - startDate.year) * 12 + endDate.month - startDate.month;
}

int numberOfYearsBetweenDates(DateTime startDate, DateTime endDate) {
  return endDate.year - startDate.year;
}

String nameCycle(DateTime startDate, DateTime endDate) {
  if (numberOfYearsBetweenDates(startDate, endDate) != 0) {
    return 'Year ${startDate.year}';
  }
  if (numberOfMonthsBetweenDates(startDate, endDate) >= 6) {
    if (startDate.month < 7) {
      return '1st Half of  ${startDate.year}';
    }
    return '2nd Half of ${startDate.year}';
  }

  if (numberOfMonthsBetweenDates(startDate, endDate) < 6 &&
      numberOfMonthsBetweenDates(startDate, endDate) >= 1) {
    if (startDate.month <= 3) {
      return 'Quarter 1';
    }
    if (startDate.month <= 6) {
      return 'Quarter 2';
    }
    if (startDate.month <= 9) {
      return 'Quarter 3';
    }
    if (startDate.month <= 12) {
      return 'Quarter 4';
    }
  }

  if (numberOfWeeksBetweenDates(startDate, endDate) >= 1) {
    return ('${DateFormat.MMMM().format(startDate)} ${startDate.year}');
  }
  return 'Not Known';
}
