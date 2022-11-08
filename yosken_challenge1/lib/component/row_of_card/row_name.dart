import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';
import 'package:yosken_challenge1/component/card_row.dart';

Widget makeRowOfName(ChargerSpot chargerSpot)=>Padding(
  padding: cardNamePadding,
  child: Container(
    height: cardNameHeight,
    alignment: Alignment.centerLeft,
    child: Text(
      chargerSpot.name!,
      style: const TextStyle(
          fontSize: cardNameFontSize, fontWeight: FontWeight.bold),
    ),
  ),
);