import 'package:flutter/material.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';

Widget makeRowOfImage(ChargerSpot chargerSpot) {
  final images = chargerSpot.images!;
  final length = images.length;
  if (length == 1) {
    final url = images[0].url;
    return SizedBox(
      height: cardImageHeight,
      width: double.infinity,
      child: Image(
        image: NetworkImage(url!),
        fit: BoxFit.cover,
      ),
    );
  } else if (length > 1) {
    final firstUrl = images[0].url;
    final secondUrl = images[1].url;
    return SizedBox(
      height: cardImageHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: NetworkImage(firstUrl!),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: gapTwoImages),
          Expanded(
            child: Image(
              image: NetworkImage(secondUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  } else {
    return const SizedBox(
      height: cardImageHeight,
      width: double.infinity,
      child: Image(
        image: AssetImage(carImagePath),
        fit: BoxFit.cover,
      ),
    );
  }
}

