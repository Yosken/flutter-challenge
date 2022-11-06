import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'package:yosken_challenge1/component/card.dart';
import 'card_image.dart';
import 'card_listtile.dart';

List<Widget> makeCardList(ChargerSpots chargerSpots, PageController pageController) {
  final List<Widget> cardList = [];
  chargerSpots.charger_spots!.asMap().forEach((int i, chargerSpot) {
    cardList.add(makeCardForPageView(chargerSpot, pageController, i));
  });

  // for (ChargerSpot chargerSpot in chargerSpots.charger_spots!){
  //   cardList.add(makeCard(chargerSpot, pageController, ));
  // }
  return cardList;
}
