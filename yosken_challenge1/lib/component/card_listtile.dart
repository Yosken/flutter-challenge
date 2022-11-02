import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';

Widget makeListTileOfNumber(ChargerSpot chargerSpot) {
  final gogoev_charger_device = chargerSpot.gogoev_charger_devices!;
  final iconRow = makeIconRow(Icons.electrical_services, '利用可能');
  return ListTile(leading: iconRow,title: Text('12台'),);
}

Widget makeListTileOfPower(ChargerSpot chargerSpot) {
  final chargerDevices = chargerSpot.charger_devices;
  const powerKw = '不明';
  final iconRow = makeIconRow(Icons.electric_bolt, '充電出力');

  for(ChargerDevice chargerDevice in chargerDevices!){
    final power = chargerDevice.power!;
    final powerKw = '${power}kw';
    return ListTile(leading: iconRow,title: Text(powerKw),);
  }
  return ListTile(leading: iconRow,title: Text(powerKw),);
}

Widget makeListTileOfServiceTime(ChargerSpot chargerSpot) {
  final serviceTimes = chargerSpot.charger_spot_service_times;
  const serviceTime = '-';
  final iconRow = makeIconRow(Icons.access_time_outlined, '営業中　');

  for(ChargerSpotServiceTime times in serviceTimes!){
    if(times.today!){
      final startTime = times.start_time;
      final endTime = times.end_time;
      final serviceTime = '${startTime}-$endTime';
      return ListTile(leading: iconRow,title: Text(serviceTime),);
    }
  }
  return ListTile(leading: iconRow,title: Text(serviceTime),);
}

Widget makeListTileOfRegularHoliday(ChargerSpot chargerSpot) {
  final serviceTimes = chargerSpot.charger_spot_service_times;
  List<String> regularHolidayList = [];
  regularHolidayList = makeRegularHolidayList(serviceTimes!, regularHolidayList);
  final iconRow = makeIconRow(Icons.calendar_month_outlined, '定休日　');
  return ListTile(leading: iconRow,title: Text(regularHolidayList.join('、')),);
}

Widget makeIconRow(IconData iconData, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
     Icon(iconData, color: Colors.orange,) ,
      Text(text),
    ],
  );
}

List<String> makeRegularHolidayList(List<ChargerSpotServiceTime> serviceTimes, List<String> regularHoliday) {

  Map<String, String> dayOfWeek = {
    'Sunday':'日曜日',
    'Monday':'月曜日',
    'Tuesday':'火曜日',
    'Wednesday':'水曜日',
    'Thursday':'木曜日',
    'Friday':'金曜日',
    'Saturday':'土曜日',
    'Holiday':'祝日',
    'Weekday':'平日',
  };

  for(ChargerSpotServiceTime serviceTime in serviceTimes){
    if(serviceTime.business_day == 'no'){
      regularHoliday.add(dayOfWeek[serviceTime.day]!);
    }
  }
  return regularHoliday.isNotEmpty ? regularHoliday : ['-'];
}


