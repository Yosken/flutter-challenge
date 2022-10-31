import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'card_image.dart';

Widget makeCard(ChargerSpot chargerSpot) {
  return Card(
    child: Column(
      children: [
        //image(row)
        makeImageRow(chargerSpot),
        //text(name)
        Text(chargerSpot.name!)
        //listtile(number)
        //listtile(number)
        //listtile(number)
        //listtile(number)
        //text(地図アプリで経路を見る)
      ],
    )
  );
}

//
// class MakeCard {
//   final chargespots.ChargerSpot chargerSpot;
//   final int index;
//
//   MakeCard(this.chargerSpot, this.index);
// }