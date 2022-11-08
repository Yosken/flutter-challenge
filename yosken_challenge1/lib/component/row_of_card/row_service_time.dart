import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';
import 'package:yosken_challenge1/component/card_row.dart';

Widget makeRowOfServiceTime(ChargerSpot chargerSpot) {
  final serviceTimes = chargerSpot.charger_spot_service_times;
  const serviceTime = hyphen;
  for (SpotServiceTime times in serviceTimes!) {
    if (times.today!) {
      final startTime = times.start_time;
      final endTime = times.end_time;
      final serviceTime = '$startTime-$endTime';
      return makeRowForCard(timeIcon, timeTitle, serviceTime);
    }
  }
  return makeRowForCard(timeIcon, timeTitle, serviceTime);
}