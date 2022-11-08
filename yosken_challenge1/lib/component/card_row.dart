import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';

Widget makeRowForCard(IconData icons, String title, String info) => Padding(
      padding: spotInfoPadding,
      child: SizedBox(
        height: spotInfoHeight,
        child: Row(
          children: [
            Icon(
              icons,
              size: spotInfoIconSize,
              color: spotInfoIconColor,
            ),
            Text(title),
            const SizedBox(width: spotInfoMargin),
            Text(info)
          ],
        ),
      ),
    );

Widget makeRowOfNumber(ChargerSpot chargerSpot) {
  final gogoev_charger_device = chargerSpot.gogoev_charger_devices!;
  return makeRowForCard(numberIcon, numberTitle, defaultNumber);
}

Widget makeRowOfPower(ChargerSpot chargerSpot) {
  final chargerDevices = chargerSpot.charger_devices;
  const powerKw = unknown;
  for (ChargerDevice chargerDevice in chargerDevices!) {
    final power = chargerDevice.power!;
    final powerKw = '${power}kw';
    return makeRowForCard(powerIcon, powerTitle, powerKw);
  }
  return makeRowForCard(powerIcon, powerTitle, powerKw);
}

Widget makeRowOfServiceTime(ChargerSpot chargerSpot) {
  final serviceTimes = chargerSpot.charger_spot_service_times;
  const serviceTime = hyphen;
  for (SpotServiceTime times in serviceTimes!) {
    if (times.today!) {
      final startTime = times.start_time;
      final endTime = times.end_time;
      final serviceTime = '${startTime}-$endTime';
      return makeRowForCard(timeIcon, timeTitle, serviceTime);
    }
  }
  return makeRowForCard(timeIcon, timeTitle, serviceTime);
}

Widget makeRowOfRegularHoliday(ChargerSpot chargerSpot) {
  final serviceTimes = chargerSpot.charger_spot_service_times;
  List<String> regularHolidayList = [];
  regularHolidayList =
      makeRegularHolidayList(serviceTimes!, regularHolidayList);
  return makeRowForCard(
      holidayIcon, holidayTitle, regularHolidayList.join('、'));
}

List<String> makeRegularHolidayList(
    List<SpotServiceTime> serviceTimes, List<String> regularHoliday) {
  Map<String, String> dayOfWeek = {
    'Sunday': '日曜日',
    'Monday': '月曜日',
    'Tuesday': '火曜日',
    'Wednesday': '水曜日',
    'Thursday': '木曜日',
    'Friday': '金曜日',
    'Saturday': '土曜日',
    'Holiday': '祝日',
    'Weekday': '平日',
  };

  for (SpotServiceTime serviceTime in serviceTimes) {
    if (serviceTime.business_day == 'no') {
      regularHoliday.add(dayOfWeek[serviceTime.day]!);
    }
  }
  return regularHoliday.isNotEmpty ? regularHoliday : [hyphen];
}
