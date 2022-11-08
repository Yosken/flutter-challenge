import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';
import 'package:yosken_challenge1/component/card_row.dart';

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