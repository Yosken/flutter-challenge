import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';
import 'package:yosken_challenge1/component/card_row.dart';


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