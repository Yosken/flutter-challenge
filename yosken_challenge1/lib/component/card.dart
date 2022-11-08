import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:yosken_challenge1/constant/others.dart';
import 'package:yosken_challenge1/model/camera_move.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'card_image.dart';
import 'package:yosken_challenge1/component/row_of_card/importer_card_row.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';

Widget makeCard(ChargerSpot chargerSpot, PageController pageController,
    int index, context, google.GoogleMapController mapController) {
  return InkWell(
    onTap: () {
      pageController.jumpToPage(index);
      Navigator.pop(context);
      moveCameraForPageChanged(mapController, chargerSpot);
    },
    child: Padding(
      padding: const EdgeInsets.only(bottom: betweenCards),
      child: Card(
          margin: const EdgeInsets.symmetric(horizontal: paddingFromSide),
          elevation: cardElevation,
          shadowColor: cardShadowColor,
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: cardShape,
          child: Column(
            children: [
              //画像
              makeRowOfImage(chargerSpot),
              //名前
              makeRowOfName(chargerSpot),
              //充電器数
              makeRowOfNumber(chargerSpot),
              //充電出力
              makeRowOfPower(chargerSpot),
              //営業時間
              makeRowOfServiceTime(chargerSpot),
              //定休日
              makeRowOfRegularHoliday(chargerSpot),
              //リンク
              makeLinkToApp(),
            ],
          )),
    ),
  );
}

Widget makeCardForPageView(ChargerSpot chargerSpot) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: paddingCardsForPageView),
    child: Card(
      margin: EdgeInsets.zero,
        shadowColor: cardShadowColor,
        elevation: cardElevation,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: cardShape,
        child: Column(
          children: [
            //画像
            makeRowOfImage(chargerSpot),
            //名前
            makeRowOfName(chargerSpot),
            //充電器数
            makeRowOfNumber(chargerSpot),
            //充電出力
            makeRowOfPower(chargerSpot),
            //営業時間
            makeRowOfServiceTime(chargerSpot),
            //定休日
            makeRowOfRegularHoliday(chargerSpot),
            //リンク
            makeLinkToApp(),
          ],
        )),
  );
}

