// ignore_for_file: prefer_const_constructors
import 'package:date_time/date_time.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('compare time', () {
    const time = Time(21, mins: 01);
    const time2 = Time(21, mins: 01);

    time.should.be(time2);
  });

  test('compare with `isAfter`', () {
    final time = Time(21, mins: 01);
    final time2 = Time(22, mins: 01);

    time2.isAfter(time).should.beTrue();
  });

  test('compare with `isBefore`', () {
    final time = Time(21, mins: 01);
    final time2 = Time(22, mins: 01);

    time.isBefore(time2).should.beTrue();
  });

  test('compare time (2)', () {
    final time = Time(21, mins: 01);
    final time2 = Time(22, mins: 01);

    final res = time2 >= time;
    res.should.beTrue();
  });

  test('toString', () {
    const time = Time(2, mins: 1, secs: 7);
    time.toString().should.be('02:01:07');
  });

  test('toString with separator', () {
    const time = Time(2, mins: 1, secs: 7);
    time.toStringWithSeparator('-').should.be('02-01-07');
  });

  test('as overflowed', () {
    final time = Time(20).addHours(5);
    time.asOverflowed.days.should.be(1);
  });

  given('time', () {
    const time = Time(20);

    when('add hours', () {
      then('hours should be summarize', () {
        time.addHours(2).should.be(Time(22));
      });
    });

    when('add minutes', () {
      then('minutes should be summarize', () {
        time.addMinutes(2).should.be(Time(20, mins: 2));
      });
    });

    when('add seconds', () {
      then('seconds should be summarize', () {
        time.addSeconds(7).should.be(Time(20, secs: 7));
      });
    });

    when('add duration', () {
      then('should be summarize', () {
        time
            .addDuration(Duration(seconds: 77))
            .should
            .be(Time(20, mins: 1, secs: 17));
      });
    });

    when('add more hours for next day', () {
      late Time res;

      before(() {
        res = time.addHours(5);
      });

      then('type shoulde oveflowed', () {
        res.should.beOfType<OverflowedTime>();
      });

      then('shoulde be oveflowed by 1', () {
        (res as OverflowedTime).days.should.be(1);
      });

      then('hours shoudld be corrected', () {
        res.should.be(Time(1));
      });
    });
  });

  given('Time 04:05:07', () {
    const time = Time(4, mins: 5, secs: 7);
    when('foramt as `TimeStringFormat.HHmmss`', () {
      then('string should be 04:05:07', () {
        // ignore: avoid_redundant_argument_values
        time.formatAs(TimeStringFormat.HHmmss).should.be('04:05:07');
      });
    });

    when('foramt w/o parameter', () {
      then('string should be 04:05:07', () {
        time.format().should.be('04:05:07');
      });
    });

    when('foramt as `TimeStringFormat.HHmm`', () {
      then('string should be 04:05', () {
        time.formatAs(TimeStringFormat.HHmm).should.be('04:05');
      });
    });

    when('foramt as `TimeStringFormat.Hms`', () {
      then('string should be 4:5:7', () {
        time.formatAs(TimeStringFormat.Hms).should.be('4:5:7');
      });
    });

    when('foramt as `TimeStringFormat.Hm`', () {
      then('string should be 4:5', () {
        //
        time.formatAs(TimeStringFormat.Hm).should.be('4:5');
      });
    });
  });

  given('DateTime Now', () {
    final dateTime = DateTime.now();
    final dateTimeUtc = DateTime.now().toUtc();

    then('Time now should be close to', () {
      final time = Time.now;
      time.closeTo(dateTime.time).should.beTrue();
    });

    then('Time not now should be not close to', () {
      final time = Time.now.addDuration(Duration(seconds: 2));
      time.closeTo(dateTime.time).should.beFalse();
    });

    then('UTC Time now should be close', () {
      final time = Time.utcNow;
      time.closeTo(dateTimeUtc.time).should.beTrue();
    });

    then('UTC Time not now should be not close to', () {
      final time = Time.utcNow.addDuration(Duration(seconds: 2));
      time.closeTo(dateTime.time).should.beFalse();
    });
  });

  group('comparison', () {
    const time = Time(1);
    const time1 = Time(1);
    const time2 = Time(2);
    test('not equal', () {
      (time != time2).should.beTrue();
    });

    test('before', () {
      (time < time2).should.beTrue();
    });

    test('after', () {
      (time2 > time).should.beTrue();
    });

    test('before or equal', () {
      (time1 <= time1).should.beTrue();
    });

    test('after or equal', () {
      (time1 >= time1).should.beTrue();
    });
  });

  group('roundToTheNearestMin', () {
    given('Time', () {
      const time = Time(10, mins: 10);

      then('round to prev 15', () {
        final res = time.roundToTheNearestMin(15, back: true);
        res.hours.should.be(10);
        res.mins.should.be(0);
      });

      then('round to prev 10', () {
        final res = time.roundToTheNearestMin(10, back: true);
        res.hours.should.be(10);
        res.mins.should.be(10);
      });

      then('round to next 30', () {
        final res = time.roundToTheNearestMin(30);
        res.hours.should.be(10);
        res.mins.should.be(30);
      });
    });

    given('Another Time', () {
      const time = Time(21, mins: 55);

      then('round to next 30', () {
        final res = time.roundToTheNearestMin(30);
        res.hours.should.be(22);
        res.mins.should.be(00);
      });
    });

    given('Another Time', () {
      const time = Time(21, mins: 21);

      then('round to next 15', () {
        final res = time.roundToTheNearestMin(15);
        res.hours.should.be(21);
        res.mins.should.be(30);
      });

      then('round to prev 15', () {
        final res = time.roundToTheNearestMin(15, back: true);
        res.hours.should.be(21);
        res.mins.should.be(15);
      });

      then('round to next 60', () {
        final res = time.roundToTheNearestMin(60);
        res.hours.should.be(22);
        res.mins.should.be(0);
      });
    });
  });

  test('Time in seconds', () {
    const time = Time(1, mins: 5, secs: 20);
    time.inSeconds.should.be(3920);
  });

  test('Add two times', () {
    const time = Time(1, mins: 15, secs: 13);
    const anotherTime = Time(1, mins: 5, secs: 20);

    final res = time + anotherTime;

    res.inSeconds.should.be(8433);
    res.hours.should.be(2);
    res.mins.should.be(20);
    res.secs.should.be(33);
  });

  test('Add two times', () {
    const time = Time(1, mins: 5, secs: 20);
    const anotherTime = Time(1, mins: 5, secs: 20);

    final res = time + anotherTime;

    res.inSeconds.should.be(7840);
    res.hours.should.be(2);
    res.mins.should.be(10);
    res.secs.should.be(40);
  });

  test('Add two times with oveflow', () {
    const time = Time(20, mins: 30, secs: 20);
    const anotherTime = Time(9, mins: 31, secs: 15);

    final res = time + anotherTime;

    res.should.beOfType<OverflowedTime>();
    res.asOverflowed.days.should.be(1);
    res.inSeconds.should.be(108095);
    res.hours.should.be(6);
    res.mins.should.be(1);
    res.secs.should.be(35);
  });

  test('Multiple time by 3', () {
    const time = Time(1, mins: 2, secs: 3);

    final res = time * 3;

    res.hours.should.be(3);
    res.mins.should.be(6);
    res.secs.should.be(9);
  });

  test('Multiple time by 2.5', () {
    const time = Time(2, mins: 10, secs: 20);

    final res = time * 2.5;

    res.hours.should.be(5);
    res.mins.should.be(25);
    res.secs.should.be(50);
  });

  test('Multiple time by 3 (2)', () {
    const time = Time(8);

    final res = time * 3;
    res.should.beOfType<OverflowedTime>();
    res.hours.should.be(0);
    res.mins.should.be(0);
    res.secs.should.be(0);
  });

  test('Devide time by 2', () {
    const time = Time(2, mins: 10, secs: 20);

    final res = time / 2;

    res.hours.should.be(1);
    res.mins.should.be(5);
    res.secs.should.be(10);
  });

  test('Subtract two times', () {
    const time = Time(1, mins: 15, secs: 13);
    const anotherTime = Time(1, mins: 5, secs: 20);

    final res = time - anotherTime;

    res.hours.should.be(0);
    res.mins.should.be(9);
    res.secs.should.be(53);
    res.inSeconds.should.be(593);
  });

  test('Subtract two times when second time is greater', () {
    const time = Time(1, mins: 15);
    const anotherTime = Time(1, mins: 20);

    final res = time - anotherTime;

    res.hours.should.be(0);
    res.mins.should.be(0);
    res.secs.should.be(0);
    res.inSeconds.should.be(0);
  });

  group('time', () {
    const time = Time(1, mins: 15, secs: 13);

    then('total seconds should be 4513', () {
      time.inSeconds.should.be(4513);
    });

    when('add another time', () {
      const anotherTime = Time(1, mins: 5, secs: 20);
      late Time res;

      then('total seconds of another time should be 4513', () {
        anotherTime.inSeconds.should.be(3920);
      });

      before(() {
        res = time + anotherTime;
      });

      then('should summarize times', () {
        res.hours.should.be(2);
        res.mins.should.be(20);
        res.secs.should.be(33);
      });
    });
  });

  test('non oveflowed time', () {
    const time = Time(23, mins: 59, secs: 59);
    final res = time.asOverflowed;
    res.days.should.be(0);
    res.hours.should.be(23);
    res.mins.should.be(59);
    res.secs.should.be(59);
  });
}
