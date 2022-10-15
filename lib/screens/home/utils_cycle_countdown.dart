// A dart function to get the last day of the current month

import 'package:poimen/state/enums.dart';

DateTime getLastDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 0);
}

DateTime getFirstDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

int getNumberOfDaysInCycle(DateTime first, DateTime last) {
  final firstDay = getFirstDayOfMonth(first);
  final lastDay = getLastDayOfMonth(last);

  return lastDay.difference(firstDay).inDays + 1;
}

int getNumberOfDaysTillDeadline(DateTime deadline) {
  final today = DateTime.now();
  final difference = deadline.difference(today);
  return difference.inDays;
}

DateTime getNextBacentaCycleDeadline() {
  var now = DateTime.now();
  var lastDay = getLastDayOfMonth(now);
  var deadline = DateTime(lastDay.year, lastDay.month, lastDay.day, 23, 59, 59);
  return deadline;
}

DateTime getCurrentBacentaCycleStart() {
  var now = DateTime.now();
  var firstDay = getFirstDayOfMonth(now);
  var start = DateTime(firstDay.year, firstDay.month, firstDay.day, 0, 0, 0);
  return start;
}

DateTime getNextConstituencyCycleDeadline() {
  var now = DateTime.now();

  if (now.month >= 1 && now.month <= 3) {
    var lastDay = getLastDayOfMonth(DateTime(now.year, 3, 1));
    var deadline = DateTime(lastDay.year, lastDay.month, lastDay.day, 23, 59, 59);
    return deadline;
  } else if (now.month > 3 && now.month <= 6) {
    var lastDay = getLastDayOfMonth(DateTime(now.year, 6, 1));
    var deadline = DateTime(lastDay.year, lastDay.month, lastDay.day, 23, 59, 59);
    return deadline;
  } else if (now.month > 6 && now.month <= 9) {
    var lastDay = getLastDayOfMonth(DateTime(now.year, 9, 1));
    var deadline = DateTime(lastDay.year, lastDay.month, lastDay.day, 23, 59, 59);
    return deadline;
  } else if (now.month > 9 && now.month <= 12) {
    var lastDay = getLastDayOfMonth(DateTime(now.year, 12, 1));
    var deadline = DateTime(lastDay.year, lastDay.month, lastDay.day, 23, 59, 59);
    return deadline;
  } else {
    return getNextStreamCycleDeadline();
  }
}

DateTime getCurrentConstituencyCycleStart() {
  var now = DateTime.now();

  if (now.month >= 1 && now.month <= 3) {
    var firstDay = getFirstDayOfMonth(DateTime(now.year, 1, 1));
    var start = DateTime(firstDay.year, firstDay.month, firstDay.day, 0, 0, 0);
    return start;
  } else if (now.month > 3 && now.month <= 6) {
    var firstDay = getFirstDayOfMonth(DateTime(now.year, 4, 1));
    var start = DateTime(firstDay.year, firstDay.month, firstDay.day, 0, 0, 0);
    return start;
  } else if (now.month > 6 && now.month <= 9) {
    var firstDay = getFirstDayOfMonth(DateTime(now.year, 7, 1));
    var start = DateTime(firstDay.year, firstDay.month, firstDay.day, 0, 0, 0);
    return start;
  } else if (now.month > 9 && now.month <= 12) {
    var firstDay = getFirstDayOfMonth(DateTime(now.year, 10, 1));
    var start = DateTime(firstDay.year, firstDay.month, firstDay.day, 0, 0, 0);
    return start;
  } else {
    return getCurrentStreamCycleStart();
  }
}

DateTime getNextCouncilCycleDeadline() {
  var now = DateTime.now();

  if (now.month >= 1 && now.month <= 6) {
    var lastDay = getLastDayOfMonth(DateTime(now.year, 6, 1));
    var deadline = DateTime(lastDay.year, lastDay.month, lastDay.day, 23, 59, 59);
    return deadline;
  } else if (now.month > 6 && now.month <= 12) {
    var lastDay = getLastDayOfMonth(DateTime(now.year, 12, 1));
    var deadline = DateTime(lastDay.year, lastDay.month, lastDay.day, 23, 59, 59);
    return deadline;
  } else {
    return getNextStreamCycleDeadline();
  }
}

DateTime getCurrentCouncilCycleStart() {
  var now = DateTime.now();

  if (now.month >= 1 && now.month <= 6) {
    var firstDay = getFirstDayOfMonth(DateTime(now.year, 1, 1));
    var start = DateTime(firstDay.year, firstDay.month, firstDay.day, 0, 0, 0);
    return start;
  } else if (now.month > 6 && now.month <= 12) {
    var firstDay = getFirstDayOfMonth(DateTime(now.year, 7, 1));
    var start = DateTime(firstDay.year, firstDay.month, firstDay.day, 0, 0, 0);

    return start;
  } else {
    return getCurrentStreamCycleStart();
  }
}

DateTime getNextStreamCycleDeadline() {
  var now = DateTime.now();

  var lastDay = getLastDayOfMonth(DateTime(now.year, 12, 1));

  return DateTime(now.year, lastDay.month, lastDay.day, 23, 59, 59);
}

DateTime getCurrentStreamCycleStart() {
  var now = DateTime.now();

  var firstDay = getFirstDayOfMonth(DateTime(now.year, 1, 1));

  return DateTime(now.year, firstDay.month, firstDay.day, 0, 0, 0);
}

DateTime getUsersNextDeadline(ChurchLevel level) {
  if (level == ChurchLevel.fellowship || level == ChurchLevel.bacenta) {
    return getNextBacentaCycleDeadline();
  } else if (level == ChurchLevel.constituency) {
    return getNextConstituencyCycleDeadline();
  } else if (level == ChurchLevel.council) {
    return getNextCouncilCycleDeadline();
  } else {
    return getNextStreamCycleDeadline();
  }
}

int getDaysTillNextDeadline(ChurchLevel level) {
  return getNumberOfDaysTillDeadline(getUsersNextDeadline(level));
}

int getTotalNumberOfDaysInCycle(ChurchLevel level) {
  if (level == ChurchLevel.fellowship || level == ChurchLevel.bacenta) {
    return getNumberOfDaysInCycle(getCurrentBacentaCycleStart(), getNextBacentaCycleDeadline());
  } else if (level == ChurchLevel.constituency) {
    return getNumberOfDaysInCycle(
        getCurrentConstituencyCycleStart(), getNextConstituencyCycleDeadline());
  } else if (level == ChurchLevel.council) {
    return getNumberOfDaysInCycle(getCurrentCouncilCycleStart(), getNextCouncilCycleDeadline());
  } else {
    return getNumberOfDaysInCycle(getCurrentStreamCycleStart(), getNextStreamCycleDeadline());
  }
}
