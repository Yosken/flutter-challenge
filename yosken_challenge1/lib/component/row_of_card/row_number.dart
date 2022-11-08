import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';
import 'package:yosken_challenge1/component/card_row.dart';

Widget makeRowOfNumber(ChargerSpot chargerSpot) {
  final gogoev_charger_device = chargerSpot.gogoev_charger_devices!;
  return makeRowForCard(numberIcon, numberTitle, defaultNumber);
}