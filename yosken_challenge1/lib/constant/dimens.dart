import 'package:flutter/cupertino.dart';

//Cardの充電スポットの画像が２枚の時の距離
const double gapTwoImages = 4.0;

//Cardのspot情報部分のPadding
const double spotInfoPaddingFromL = 16;
const double spotInfoPaddingFromT = 0;
const double spotInfoPaddingFromR = 16;
const double spotInfoPaddingFromB = 12;
const EdgeInsets spotInfoPadding = EdgeInsets.fromLTRB(spotInfoPaddingFromL, spotInfoPaddingFromT, spotInfoPaddingFromR, spotInfoPaddingFromB);

const double spotInfoHeight = 19;
const double spotInfoIconSize = 14;
const double spotInfoMargin = 28;
const double spotInfoFontSize = 14;

//card
const double betweenCards = 20;
const double paddingFromSide = 32;
const double cardElevation = 10;
const double cardImageHeight = 72;
const EdgeInsets cardNamePadding = EdgeInsets.fromLTRB(16, 8, 16, 8);
const double cardNameHeight = 25;
const double cardNameFontSize = 18;
const EdgeInsets linkToAppPadding = EdgeInsets.fromLTRB(16,0,16,16);
const double marginCardFromB = 18;
const double paddingCardsForPageView = 8;


const double fontSizeForSpotName = 18;

const double noSpotResultTextHeight = 100;
const double noSpotResultTextWidth = 400;

//PageViewのページが表示される割合
const double viewPageFraction = 0.85;
const double marginPageViewFromB = 40;
const double loadingPageViewIndicatorPadding = 116;
const double loadingPageViewIndicatorSize = 80;

//検索ボタン
const double marginForSearchButton = 60;
const EdgeInsets marginForTextOfSearchButton = EdgeInsets.symmetric(horizontal: 27);
const double searchButtonSize = 396;

//Cardのサイズ
const double cardWidth = 365;
const double cardHeight = 272;

//現在地ボタンの直径
const double myLocationButtonSize = 62;
const EdgeInsets myLocationButtonPadding = EdgeInsets.fromLTRB(0, 0, 16, 16);

//Google Mapのズーム値
const double defaultZoom = 14;

//リスト表示ボタン
const double showListButtonWidth = 140;
const double showListButtonHeight = 45;

//リスト表示ボタンと現在地ボタンの距離
const double betweenListButtonAndMyLocation = 8;

//起動時の検索範囲
const double firstSwLat = 34.683331703634124;
const double firstSwLng = 139.7657155055581;
const double firstNeLat = 35.686849507072736;
const double firstNeLng = 139.77340835691592;

//初期カメラ位置(東京駅)
const double firstLat =  35.681789;
const double firstLng =  139.766948;

//DraggableScrollableSheetの引数
const double  draggableScrollableSheetFraction = 0.92;

//マップのカメラ中心のオフセット
const EdgeInsets mapCenterPosition = EdgeInsets.fromLTRB(0, 0, 0, 240);

const int markerSize = 150;


