import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:itaxi/screen/listpage.dart';
import 'package:itaxi/screen/timelinepage.dart';
import 'package:itaxi/settings/setting.dart';
import 'package:itaxi/themes.dart';

import 'chatRoom/chatRoomMain.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;
  int backPressCounter = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  Widget build(BuildContext context) {
    // dialog 띄우고 종료하기
    Future<bool> exitWithDialog(){
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("정말 종료하시겠습니까?"),
            actions: <Widget>[
              TextButton(
                child: Text("아니오"),
                onPressed: ()=>Navigator.pop(context, false),
              ),
              TextButton(
                child: Text("예"),
                onPressed: ()=>{
                  // 앱 종료
                  SystemChannels.platform.invokeListMethod('SystemNavigator.pop'),
                  Navigator.pop(context, true),
                }
              )
            ],
          )
      );
    }

    // Toast 띄우고 종료하기
    Future<bool> exitWithToast() {
      final isFirstRouteInCurrentTab = _navigatorKeys[_selectedIndex].currentState.maybePop();

      if (backPressCounter < 1) {
        // Fluttertoast.showToast(msg: "한번 더 누르면 종료됩니다.");
        backPressCounter++;
        Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
          backPressCounter--;
        });
        return Future.value(false);
      } else {
        // 앱 종료
        SystemChannels.platform.invokeListMethod('SystemNavigator.pop');
        return Future.value(true);
      }
    }

    // 뒤로가기 버튼 클릭 방지
    return WillPopScope(
      onWillPop: exitWithToast,
      // onWillPop: exitWithDialog,

      // onWillPop: () async {
      //   final isFirstRouteInCurrentTab =
      //   !await _navigatorKeys[_selectedIndex].currentState.maybePop();
      //
      //   // print(
      //   //     'isFirstRouteInCurrentTab: ' + isFirstRouteInCurrentTab.toString());
      //
      //   // let system handle back button if we're on the first route
      //   return isFirstRouteInCurrentTab;
      // },

      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.access_time,
                // color: kGoodLightGray,
                size: bottomIconSize,     // from theme.dart
              ),
              title: Text('지난기록'),
              activeIcon: Icon(
                Icons.access_time,
                // color: kGoodPurple,
                size: bottomIconSize,     // from theme.dart
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_taxi,
                // color: kGoodLightGray,
                size: bottomIconSize,     // from theme.dart
              ),
              title: Text('조회 / 모집'),
              activeIcon: Icon(
                Icons.local_taxi,
                // color: kGoodPurple,
                size: bottomIconSize,     // from theme.dart
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more_horiz,
                // color: kGoodLightGray,
                size: bottomIconSize,     // from theme.dart
              ),
              title: Text('더 보기'),
              activeIcon: Icon(
                Icons.more_horiz,
                // color: kGoodPurple,
                size: bottomIconSize,     // from theme.dart
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
          ],
        ),
      ),
    );
  }

  void _next(newScreen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => newScreen));
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [

          TimeLine(),
          TaxiCarList(onNext: _next,),
          Settings(onNext: _next,),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }
}