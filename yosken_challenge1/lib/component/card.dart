import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:yosken_challenge1/src/chargespots.dart';
import 'card_image.dart';
import 'card_listtile.dart';

Widget makeCard(ChargerSpot chargerSpot, PageController pageController,
    int index, context, google.GoogleMapController mapController) {
  return InkWell(
    onTap: () {
      pageController.jumpToPage(index);
      Navigator.pop(context);
      mapController.animateCamera(google.CameraUpdate.newCameraPosition(
          google.CameraPosition(
              target:
                  google.LatLng(chargerSpot.latitude!, chargerSpot.longitude!),
              zoom: 14)));
    },
    child: Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 32),
          elevation: 10,
          shadowColor: Colors.black.withOpacity(0.30),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Container(
                  height: 25,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    chargerSpot.name!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // listtile(number)
              makeRowOfNumber(chargerSpot),
              //listtile(power)
              makeRowOfPower(chargerSpot),
              //listtile(serviceTime)
              makeRowOfServiceTime(chargerSpot),
              //listtile(number)
              makeRowOfRegularHoliday(chargerSpot),
              //text(地図アプリで経路を見る)
              Padding(
                padding: const EdgeInsets.fromLTRB(16,0,16,16),
                child: SizedBox(
                  height: 19,
                  child: Row(
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
                ),
              ),
            ],
          )),
    ),
  );
}

Widget makeCardForPageView(ChargerSpot chargerSpot) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Card(
      margin: EdgeInsets.zero,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Container(
                height: 25,
                alignment: Alignment.centerLeft,
                child: Text(
                  chargerSpot.name!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // listtile(number)
            makeRowOfNumber(chargerSpot),
            //listtile(power)
            makeRowOfPower(chargerSpot),
            //listtile(serviceTime)
            makeRowOfServiceTime(chargerSpot),
            //listtile(number)
            makeRowOfRegularHoliday(chargerSpot),
            //text(地図アプリで経路を見る)
            Padding(
              padding: const EdgeInsets.fromLTRB(16,0,16,16),
              child: SizedBox(
                height: 19,
                child: Row(
                  children: const [
                    Text(
                      '地図アプリで経路を見る',
                      style: TextStyle(color: Colors.lightGreen, fontSize: 14),
                    ),
                    Icon(
                      Icons.layers_outlined,
                      color: Colors.lightGreen,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
  );
}

// Widget makeCard(ChargerSpot chargerSpot) {
//   return Card(
//       margin: EdgeInsets.only(bottom: 20),
//       shadowColor: Colors.black.withOpacity(0.45),
//       elevation: 12,
//       color: Colors.white,
//       clipBehavior: Clip.antiAlias,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         children: [
//           //image(row)
//           SizedBox(
//               height: 72,
//               width: double.infinity,
//               child: makeImageRow(chargerSpot)),
//           //text(name)
//           ListTile(
//             leading: Text(
//               chargerSpot.name!,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           // listtile(number)
//           makeListTileOfNumber(chargerSpot),
//           //listtile(power)
//           makeListTileOfPower(chargerSpot),
//           //listtile(serviceTime)
//           makeListTileOfServiceTime(chargerSpot),
//           //listtile(number)
//           makeListTileOfRegularHoliday(chargerSpot),
//           //text(地図アプリで経路を見る)
//           ListTile(
//             leading: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: const [
//                 Text(
//                   '地図アプリで経路を見る',
//                   style: TextStyle(color: Colors.lightGreen, fontSize: 14),
//                 ),
//                 Icon(
//                   Icons.layers_outlined,
//                   color: Colors.lightGreen,
//                   size: 18,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ));
// }
