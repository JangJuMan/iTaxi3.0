import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'chatRoom/chatRoomMain.dart';
import 'settings/setting.dart';
import 'screen/listpage.dart';
import 'signInUp/signIn.dart';
import 'signInUp/signUp.dart';
import 'themes.dart';
//
// void main() {
//   runApp(
//     // ChatRoomMain(),
//     // SettingPage(),
//     ListOfRooms(),
//   );
// }
//

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
      // 테마는 테마파일에서 한꺼번에 관리하는걸로 갑시다.
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home:
      SignIn(),
       //SignUp(),
      //ChatScreen(),
       //TaxiCarList(),
       //Settings(title: '설정'),
    );
  }
}