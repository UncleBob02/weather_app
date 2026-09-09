String formatForecastDate(DateTime date) {
  final today = DateTime.now();

  if (date.year == today.year &&
    date.month == today.month &&
    date.day == today.day) {
      return 'Today';
    }

  return switch (date.weekday) {
    DateTime.monday => 'Mon',
    DateTime.tuesday => 'Tue',
    DateTime.wednesday => 'Wed',
    DateTime.thursday => 'Thu',
    DateTime.friday => 'Fri',
    DateTime.saturday => 'Sat',
    DateTime.sunday => 'Sun',
    _ => '',
  };
}