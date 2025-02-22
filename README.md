[![pub package](https://img.shields.io/pub/v/date_time.svg?label=date_time&color=blue)](https://pub.dev/packages/date_time)
[![codecov](https://codecov.io/gh/AndrewPiterov/date_time/branch/dev/graph/badge.svg?token=VM9LTJXGQS)](https://codecov.io/gh/AndrewPiterov/date_time)
[![likes](https://badges.bar/date_time/likes)](https://pub.dev/packages/date_time/score)
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)
[![Dart](https://github.com/AndrewPiterov/date_time/actions/workflows/dart.yml/badge.svg)](https://github.com/AndrewPiterov/date_time/actions/workflows/dart.yml)

# date_time

Package to work with **Date** & **Time** in separation and with its ranges.

This project will be useful for projects that are related to booking.

## Features

* Only Date comparison
* Only Time comparison
* Overflowed Time with keeping days
* Find crossing of dates
* Find crossing of times in the day

## Getting started

1. Add dependency

```yml
dependencies:
  date_time: <newest>
```

2. Import the dependency

```dart
import 'package:date_time/date_time.dart';
```

## Usage

Please, check ([examples](./example/dates.dart)) folder for more advanced examples.

### Date

```dart
// Get [Date] & [Time] from [DateTime]
print(DateTime(2022, 1, 6).date); // prints 1/6/2022
print(DateTime(7, 38, 24).time); // 07:38:24
```

```dart
given('DateTime', () {
  final dateTime = DateTime(2020, 11, 30, 14, 33, 17);

  then('[Date] should be equal to', () {
    dateTime.date.should.be(Date(2020, 11, 30));
  });

  then('[Time] should be equal to', () {
    dateTime.time.should.be(Time(14, mins: 33, secs: 17));
  });
});
```

### DateRange

```dart
final range = DateRange(
  const Date(2021, 1, 1),
  const Date(2021, 12, 31),
);

test('should be valid', () {
  range.isValid.should.beTrue();
});
```

### Time

```dart
final time2 = time.addMinutes(30);
final isTime2After = time2 > time;
final isTime2After2 = time2.isAfter(time);
print('Is time2 after: $isTime2After');
```

### Overflowed Time

to keep days

```dart
final time = Time(20).addHours(5);

print(time is OverflowedTime); // prints `true`
print(time.asOverflowed.days); // prints `1`

```

### TimeRange

```dart
// TimeRange crossing
final timeRange = TimeRange(Time.now, Time.now.addHours(6));
final timeRange2 = TimeRange(Time.now.addHours(3), Time.now.addHours(9));

final isCrossing = timeRange.isCross(timeRange2);
print('Time ranges are crossing: $isCrossing');
```

## Changelog

Please see the [Changelog](CHANGELOG.md) page to know what's recently changed.

## Contributing

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/AndrewPiterov/date_time/issues/new).\
If you fixed a bug or implemented a new feature, please send a [pull request](https://github.com/AndrewPiterov/date_time/pulls).

We accept the following contributions:

* New features
* Improving documentation
* Fixing bugs

## Maintainers

* [Andrew Piterov](mailto:contact@andrewpiterov.com?subject=[GitHub]%20Source%20Dart%20date_time)

<a href="https://www.buymeacoffee.com/devcraft.ninja" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Support me" height="41" width="174"></a>
