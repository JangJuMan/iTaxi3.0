import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // 테마

// IOS 테마
final ThemeData kIOSTheme = ThemeData(
  // [1]: 오렌지 엑센트가 있는 밝은 회색
  // primarySwatch: Colors.orange,
  // primaryColor: Colors.grey[100],
  // primaryColorBrightness: Brightness.light,

  // [2]:
  primarySwatch: Colors.blue,
  primaryColor: Colors.blueAccent[100],
  primaryColorBrightness: Brightness.light,
);

// Android 테마
final ThemeData kDefaultTheme = ThemeData(
  // 주황색 엑센트가 있는 보라
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

// 색깔 상수
const kGoodPurple = Color(0xFF9E8ACF);
const kGoodPurpleLight = Color(0xFFEDE8FF);
const kGoodPurpleLight2 = Color(0xFFF9F6FF);

const kGoodOrange = Color(0xFFF08F7F);
const kGoodOrange2 = Color(0xFFF8C3BB);
const kGoodDarkGray = Color(0xFF969696);
const kGoodDarkGray2 = Color(0xFF777777);
const kGoodDarkGray3 = Color(0xFF272727);
const kGoodLightGray = Color(0xFFCDCDCD);
const kGoodLightGray2 = Color(0xFFC9C9C9);
const kGoodMidGray = Color(0xFFEEEEEE);

const kHeadingTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w800,
);


// 바텀 아이콘 사이즈
const double bottomIconSize = 30;