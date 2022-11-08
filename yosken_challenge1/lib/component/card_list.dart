import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'package:yosken_challenge1/component/card.dart';
import 'package:yosken_challenge1/component/card_no_result.dart';

List<Widget> makeCardListForPageView(ChargerSpots chargerSpots) {
  final List<Widget> cardList = [];
  if(chargerSpots.charger_spots!.isNotEmpty){
    chargerSpots.charger_spots!.asMap().forEach((int i, chargerSpot) {
      cardList.add(makeCardForPageView(chargerSpot));
    });
    return cardList;
  } else {
    cardList.add(makeNoResultCard());
    return cardList;
  }
}
