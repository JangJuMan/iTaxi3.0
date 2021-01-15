import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:itaxi/mainScreen.dart';
import 'package:itaxi/signInUp/signIn.dart';
import 'package:itaxi/signInUp/signUp.dart';
import 'package:itaxi/themes.dart';

import 'chatRoom/chatRoomMain.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iTaxi Test',
      // 테마는 테마파일에서 한꺼번에 관리하는걸로 갑시다.
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
      routes: {
        'SignIn': (context) => SignIn(),
        'SignUp': (context) => SignUp(),
        'MainScreen': (context) => MainScreen(),
        'ChatScreen': (context) => ChatScreen(),
      },
      home: SignIn(),
    );
  }
}
