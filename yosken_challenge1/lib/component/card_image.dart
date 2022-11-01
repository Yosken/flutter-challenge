import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';

Widget makeImageRow(ChargerSpot chargerSpot) {
  final images = chargerSpot.images!;
  final length = images.length;
  if (length == 1) {
    final url = images[0].url;
    return Image(
      image: NetworkImage(url!),
      fit: BoxFit.cover,
    );
  } else if (length > 1) {
    final firstUrl = images[0].url;
    final secondUrl = images[1].url;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image(
            image: NetworkImage(firstUrl!),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Image(
            image: NetworkImage(secondUrl!),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  } else {
    return const Image(
      image: AssetImage('assets/car.png'),
      fit: BoxFit.cover,
    );
  }
}
