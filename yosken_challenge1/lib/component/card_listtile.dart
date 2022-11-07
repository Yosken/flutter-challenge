import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';

const double _heightOfListTile = 35;

const _numberIcon = Icons.electrical_services;
const _powerIcon = Icons.electric_bolt;
const _timeIcon = Icons.access_time_outlined;
const _holidayIcon = Icons.calendar_month_outlined;
const _numberTitle = '利用可能';
const _powerTitle = '充電出力';
const _timeTitle = '営業中　';
const _holidayTitle = '定休日　';

Widget makeRowForCard(IconData icons, String title, String info) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: SizedBox(
        height: 19,
        child: Row(
          children: [
            Icon(
              icons,
              size: 14,
              color: Colors.orange,
            ),
            Text(title),
            SizedBox(width: 28),
            Text(info)
          ],
        ),
      ),
    );

Widget makeRowOfNumber(ChargerSpot chargerSpot) {
  final gogoev_charger_device = chargerSpot.gogoev_charger_devices!;
  return makeRowForCard(_numberIcon, _numberTitle, '12台');
}

Widget makeRowOfPower(ChargerSpot chargerSpot) {
  final chargerDevices = chargerSpot.charger_devices;
  const powerKw = '不明';
  for (ChargerDevice chargerDevice in chargerDevices!) {
    final power = chargerDevice.power!;
    final powerKw = '${power}kw';
    return makeRowForCard(_powerIcon, _powerTitle, powerKw);
  }
  return makeRowForCard(_powerIcon, _powerTitle, powerKw);
}

Widget makeRowOfServiceTime(ChargerSpot chargerSpot) {
  final serviceTimes = chargerSpot.charger_spot_service_times;
  const serviceTime = '-';
  for (ChargerSpotServiceTime times in serviceTimes!) {
    if (times.today!) {
      final startTime = times.start_time;
      final endTime = times.end_time;
      final serviceTime = '${startTime}-$endTime';
      return makeRowForCard(_timeIcon, _timeTitle, serviceTime);
    }
  }
  return makeRowForCard(_timeIcon, _timeTitle, serviceTime);
}

Widget makeRowOfRegularHoliday(ChargerSpot chargerSpot) {
  final serviceTimes = chargerSpot.charger_spot_service_times;
  List<String> regularHolidayList = [];
  regularHolidayList =
      makeRegularHolidayList(serviceTimes!, regularHolidayList);
  return makeRowForCard(
      _holidayIcon, _holidayTitle, regularHolidayList.join('、'));
}

List<String> makeRegularHolidayList(
    List<ChargerSpotServiceTime> serviceTimes, List<String> regularHoliday) {
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

  for (ChargerSpotServiceTime serviceTime in serviceTimes) {
    if (serviceTime.business_day == 'no') {
      regularHoliday.add(dayOfWeek[serviceTime.day]!);
    }
  }
  return regularHoliday.isNotEmpty ? regularHoliday : ['-'];
}
