import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'chatRoom/chatRoomMain.dart';
import 'settings/setting.dart';
import 'screen/listpage.dart';
import 'signInUp/signIn.dart';
import 'signInUp/signUp.dart';
import 'themes.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iTaxi Test',
      // 테마는 테마파일에서 한꺼번에 관리하는걸로 갑시다.
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
      // initialRoute: 'SignIn',
      routes: {
        'SignIn': (context) => SignIn(),
        'SignUp': (context) => SignUp(),
        'TapMenus': (context) => TapMenus(),
        'TaxiCarList': (context) => TaxiCarList(),
        'Settings': (context) => Settings(),
        'ChatScreen': (context) => ChatScreen(),
      },
      home: SignIn(),
    );
  }
}

class ContextKeeper {
  static BuildContext buildContext;

  void init(BuildContext context) {
    buildContext = context;
  }
}

class TapMenus extends StatefulWidget {
  TapMenus({Key key}) : super(key: key);

  @override
  _TapMenusState createState() => _TapMenusState();
}

_TapMenusState tmState = new _TapMenusState();


class _TapMenusState extends State<TapMenus> {
  int _selectedIndex = 1;
  static const double _tapIconSize = 30.0;
  static List<Widget> menuList = <Widget>[
    Center(child: Text('지난 기록 페이지')),
    TaxiCarList(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('hello'),),
      body: menuList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        // 탭 메뉴 글씨 지움.
        showSelectedLabels: false,
        showUnselectedLabels: false,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time, size: _tapIconSize),
            // 이런 것도 있더라 ~
            activeIcon: Icon(Icons.access_time, size: _tapIconSize),
            title: Text('지난기록'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_taxi, size: _tapIconSize),
            title: Text('조회 / 모집'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz, size: _tapIconSize),
            title: Text('더 보기'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}



