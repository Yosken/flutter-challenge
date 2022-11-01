import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';

Widget makeListTile(ChargerSpot chargerSpot) {
  final gogoev_charger_device = chargerSpot.gogoev_charger_devices!;
  final iconRow = makeIconRow(Icons.electrical_services, '利用可能');
  return ListTile(leading: iconRow,title: Text('12台'),);
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