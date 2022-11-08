import 'package:flutter/material.dart';
import 'importer_constant.dart';

///Loading時のindicator
const Widget loadingIndicatorForPageView = Padding(
  padding: EdgeInsets.symmetric(vertical: loadingPageViewIndicatorPadding),
  child: SizedBox(
      height: loadingPageViewIndicatorSize,
      width: loadingPageViewIndicatorSize,
      child: CircularProgressIndicator()),
);
const Widget loadingIndicatorForListView = Center(
    child: SizedBox(
        height: loadingPageViewIndicatorSize,
        width: loadingPageViewIndicatorSize,
        child: CircularProgressIndicator()));

///検索ボタン
final Widget searchButtonWidget = Padding(
  padding: marginForTextOfSearchButton,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Text(textForSearching),
      Icon(searchIcon),
    ],
  ),
);

final Widget showListButtonRow = Row(
  children: const [
    Icon(iconForShowList),
    Text(
      textForShowList,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  ],
);

const Widget betweenListButtonAndMyLocationSizedBox = SizedBox(
  width: betweenListButtonAndMyLocation,
);

const myLocationIconWidget = Icon(
  myLocationIcon,
  color: Colors.white,
);



