extension ToDateString on DateTime {
  static String _fourDigits(int n) {
    final int absN = n.abs();
    final String sign = n < 0 ? '-' : '';
    if (absN >= 1000) {
      return '$n';
    }
    if (absN >= 100) {
      return '${sign}0$absN';
    }
    if (absN >= 10) {
      return '${sign}00$absN';
    }
    return '${sign}000$absN';
  }

  static String _twoDigits(int n) {
    if (n >= 10) {
      return '$n';
    }
    return '0$n';
  }

  String toDateString() {
    final String y = _fourDigits(year);
    final String m = _twoDigits(month);
    final String d = _twoDigits(day);
    return '$y-$m-$d';
  }
}
