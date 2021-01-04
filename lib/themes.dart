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
