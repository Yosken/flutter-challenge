import 'package:flutter/material.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';

Widget makeLinkToApp() => Padding(
  padding: linkToAppPadding,
  child: SizedBox(
    height: spotInfoHeight,
    child: Row(
      children: const [
        Text(
          linkToAppText,
          style: TextStyle(color: linkToAppColor, fontSize: spotInfoFontSize,decoration: TextDecoration.underline),
        ),
        Icon(
          Icons.layers_outlined,
          color: linkToAppColor,
          size: spotInfoIconSize,
        ),
      ],
    ),
  ),
);