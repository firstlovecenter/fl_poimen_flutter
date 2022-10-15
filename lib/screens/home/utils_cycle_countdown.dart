// A dart function to get the last day of the current month

DateTime getLastDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 0);
}

DateTime getFirstDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

int getNumberOfDaysTillDeadline(DateTime deadline) {
  final today = DateTime.now();
  final difference = deadline.difference(today);
  return difference.inDays;
}
