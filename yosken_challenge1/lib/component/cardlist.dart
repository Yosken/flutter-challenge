import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'package:yosken_challenge1/component/card.dart';
import 'card_image.dart';
import 'card_listtile.dart';

List<Widget> makeCardList(ChargerSpots chargerSpots) {
  final List<Widget> cardList = [];
  for (ChargerSpot chargerSpot in chargerSpots.charger_spots!){
    cardList.add(makeCard(chargerSpot));
  }
  return cardList;
}
