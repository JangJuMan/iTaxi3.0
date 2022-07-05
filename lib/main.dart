import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:itaxi/mainScreen.dart';
import 'package:itaxi/signInUp/signIn.dart';
import 'package:itaxi/signInUp/signUp.dart';
import 'package:itaxi/themes.dart';
import 'package:get/get.dart';

import 'chatRoom/chatRoomMain.dart';

import 'settings/setting.dart';
import 'screen/listpage.dart';
import 'screen/timelinepage.dart';
import 'signInUp/signIn.dart';
import 'signInUp/signUp.dart';
import 'themes.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'iTaxi Test',
      // 테마는 테마파일에서 한꺼번에 관리하는걸로 갑시다.

      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),

      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
      // 네비게이션 할 메뉴이름 써놓은거
      // routes: {
      //   'SignIn': (context) => SignIn(),
      //   'SignUp': (context) => SignUp(),
      //   'MainScreen': (context) => MainScreen(),
      //   // 'ChatScreen': (context) => ChatScreen(),
      //   'RideLog' : (context) => TimeLine(),
      // },
      home: SignIn(),


    );
  }
}
