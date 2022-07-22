class AppConstants {
  static String getFeelingsEmoji(String text) {
    switch (text) {
      case 'Happy':
        return '🤣';
      case 'Sad':
        return '😭';
      case 'Energetic':
        return '⚡️';
      case 'Calm':
        return '😌';
      case 'Angry':
        return '😡';
      case 'Bored':
        return '😑';

      default:
        return '😀';
    }
  }

  static String getWeekDay(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mo';
      case 2:
        return 'Tu';
      case 3:
        return 'We';
      case 4:
        return 'Th';
      case 5:
        return 'Fr';
      case 6:
        return 'Sa';
      case 7:
        return 'Su';
      default:
        return '😀';
    }
  }

  static List<DateTime> getDates(DateTime startDate) {
    final items = List<DateTime>.generate(
        30,
        (i) => DateTime.utc(
              startDate.year,
              startDate.month,
              startDate.day,
            ).add(Duration(days: i)));
    return items;
  }
}
