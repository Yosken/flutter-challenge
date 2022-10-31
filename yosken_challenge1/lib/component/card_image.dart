import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';

Widget makeImageRow(ChargerSpot chargerSpot) {
  final images = chargerSpot.images!;
  final length = images.length;
  if(length == 1) {
    final url = images[0].url;
    return Image.network(url!);
  } else if(length > 1){
    final firstUrl = images[0].url;
    final secondUrl = images[1].url;
    return Row(
      children: [
        Image.network(firstUrl!),
        Image.network(secondUrl!),
      ],
    );
  } else {
    return Image.asset('assets/car.png');
  }
}