part of common;

class CustomColors {
  static const Color primaryYellow = Color(0xFFFFCC00);
  static const Color primaryGreen = Color(0xFF00CC33);
  static const Color primaryBlue = Color(0xFF0099FF);
  static const Color primaryOrange = Color(0xFFFF9900);
}

class CustomSpacing {
  static const SizedBox verticalSpace8 = SizedBox(height: 8);
  static const SizedBox verticalSpace16 = SizedBox(height: 16);
  static const SizedBox verticalSpace24 = SizedBox(height: 24);

  static const SizedBox horizontalSpace8 = SizedBox(width: 8);
  static const SizedBox horizontalSpace16 = SizedBox(width: 16);
  static const SizedBox horizontalSpace24 = SizedBox(width: 24);
}

class CustomDateFormat {
  static String getMonthName(int month) {
    if (month < 1 || month > 12) return '';

    const months = {
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December'
    };

    return months[month] ?? '';
  }

  static String getShortMonthName(int month) {
    if (month < 1 || month > 12) return '';
    return getMonthName(month).substring(0, 3);
  }

  static String formatDate(DateTime date,
      {bool shortMonth = false, bool includeTime = true}) {
    final monthName =
        shortMonth ? getShortMonthName(date.month) : getMonthName(date.month);

    final dateStr = '${date.day} $monthName ${date.year}';

    if (!includeTime) return dateStr;

    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$dateStr at $hour:$minute';
  }
}
