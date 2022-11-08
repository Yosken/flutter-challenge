import 'package:flutter/material.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';

Widget makeNoResultCard() => Stack(children: [
  Center(
          child: SizedBox(
              height: noSpotResultTextHeight,
              width: noSpotResultTextWidth,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: myLocationBtnBackColor,
                  disabledForegroundColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                onPressed: null,
                child: const Text(noSpotResult,
                  style: TextStyle(fontSize: fontSizeForSpotName ),
                ),
              ))),
      Container()
    ]);
