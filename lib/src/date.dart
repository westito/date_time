import 'package:quiver/core.dart';

/// Date object
class Date {
  final int day;
  final int month;
  final int year;

  /// Initialize `Date` object
  const Date(
    this.year,
    this.month,
    this.day,
  );

  ///
  Date.from(DateTime dt)
      : year = dt.year,
        month = dt.month,
        day = dt.day;

  String get withoutSeparator => toString().replaceAll('-', '');
  String withSeparator(String separator) =>
      toString().replaceAll('-', separator);

  int get weekday => DateTime(year, month, day).weekday;

  DateTime get asDateTime => DateTime(year, month, day);

  Date add(Duration duration) {
    final t = asDateTime.add(duration);
    return Date(t.year, t.month, t.day);
  }

  Date addDays(int amount) {
    final t = asDateTime.add(Duration(hours: amount * 24));
    return Date(t.year, t.month, t.day);
  }

  bool isSame(Date date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool isAfter(Date after, {bool orSame = false}) {
    if (year < after.year) {
      return false;
    }

    if (year > after.year) {
      return true;
    }

    // years are equal - comapre month
    if (month < after.month) {
      return false;
    }

    if (month > after.month) {
      return true;
    }

    // months are equal - comapre days
    if (day < after.day) {
      return false;
    }

    if (day > after.day) {
      return true;
    }

    return orSame;
  }

  bool get isToday {
    return year == today.year && month == today.month && day == today.day;
  }

  static Date get today => Date.from(DateTime.now());

  static Date get tomorrow =>
      Date.from(DateTime.now().add(const Duration(hours: 24)));

  bool operator >(Date other) {
    return isAfter(other);
    //   asDateTime.isAfter(other.asDateTime);
  }

  bool operator >=(Date other) {
    return isAfter(other, orSame: true);
    // final otherDateTime = other.asDateTime;
    // return otherDateTime == otherDateTime || asDateTime.isAfter(otherDateTime);
  }

  bool operator <(Date other) {
    return other.isAfter(this);
    // return other.asDateTime.isAfter(asDateTime);
  }

  bool operator <=(Date other) {
    return other.isAfter(this, orSame: true);
    // final otherDateTime = other.asDateTime;
    // return otherDateTime == otherDateTime || otherDateTime.isAfter(asDateTime);
  }

  @override
  bool operator ==(Object other) =>
      other is Date &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  @override
  int get hashCode => hash3(
        year.hashCode,
        month.hashCode,
        day.hashCode,
      );

  @override
  String toString() => [
        year,
        month.toString().padLeft(2, '0'),
        day.toString().padLeft(2, '0'),
      ].join('-');
}
