import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'card_image.dart';
import 'card_listtile.dart';

Widget makeCard(ChargerSpot chargerSpot) {
  return Card(
      margin: EdgeInsets.only(bottom: 20),
      shadowColor: Colors.black.withOpacity(0.45),
      elevation: 12,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          //image(row)
          SizedBox(
              height: 72,
              width: double.infinity,
              child: makeImageRow(chargerSpot)),
          //text(name)
          ListTile(
            leading: Text(
              chargerSpot.name!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // listtile(number)
          makeListTileOfNumber(chargerSpot),
          //listtile(power)
          makeListTileOfPower(chargerSpot),
          //listtile(serviceTime)
          makeListTileOfServiceTime(chargerSpot),
          //listtile(number)
          makeListTileOfRegularHoliday(chargerSpot),
          //text(地図アプリで経路を見る)
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  '地図アプリで経路を見る',
                  style: TextStyle(color: Colors.lightGreen, fontSize: 14),
                ),
                Icon(
                  Icons.layers_outlined,
                  color: Colors.lightGreen,
                  size: 18,
                ),
              ],
            ),
          )
        ],
      ));
}

//
// class MakeCard {
//   final chargespots.ChargerSpot chargerSpot;
//   final int index;
//
//   MakeCard(this.chargerSpot, this.index);
// }
