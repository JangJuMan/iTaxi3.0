import 'package:flutter/material.dart';
import 'package:itaxi/chatRoom/chatRoomMain.dart';
import 'package:itaxi/screen/pluspage.dart';
import 'package:flutter/cupertino.dart';
import 'package:itaxi/settings/setting.dart';

import '../customPageRoutes.dart';
import '../main.dart';


class TaxiCarList extends StatefulWidget {
  final Function onNext;

  TaxiCarList({Key key, this.title, this.onNext}) : super(key: key);
  final String title;

  @override
  _TaxiCarListState createState() => _TaxiCarListState(onNext);
}

class TaxiList extends StatefulWidget {
  final Function onNext;
  final String title;

  TaxiList({Key key, this.title, this.onNext}) : super(key: key);

  @override
  _TaxiListState createState() => _TaxiListState(onNext);
}

class CarList extends StatefulWidget {
  final String title;
  final Function onNext;

  CarList({Key key, this.title, this.onNext}) : super(key: key);


  @override
  _CarListState createState() => _CarListState(onNext);
}

class LeaveMenu extends StatefulWidget {
  LeaveMenu({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LeaveMenuState createState() => _LeaveMenuState();
}

class ArriveMenu extends StatefulWidget {
  ArriveMenu({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ArriveMenuState createState() => _ArriveMenuState();
}

class CalendarSection extends StatefulWidget {
  CalendarSection({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CalendarState createState() => _CalendarState();
}

// List<String> places = [
//   "한동대",
//   "커피유야",
//   "다이소",
//   "세차장",
//   "포항역",
//   "시외버스터미널",
//   "E1"
// ];


//Leave dropdown menu
class _LeaveMenuState extends State<LeaveMenu> {
  String dropdownValue = null;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Center(
        child: Text('출발'),
      ),
      value: dropdownValue,
      // icon: Icon(Icons.arrow_drop_down_outlined),
      iconEnabledColor: Colors.black26,
      iconSize: 25,
      elevation: 12,
      style: TextStyle(color: Colors.black),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['한동대', '커피유야', '다이소', '세차장', '포항역', '직접입력']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

//Arrive dropdown menu
class _ArriveMenuState extends State<ArriveMenu> {
  String dropdownValue = null;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('도착'),
      value: dropdownValue,
      // icon: Icon(Icons.arrow_drop_down_outlined),
      iconEnabledColor: Colors.black26,
      iconSize: 25,
      elevation: 12,
      style: TextStyle(color: Colors.black),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['한동대', '커피유야', '다이소', '세차장', '포항역', '직접입력']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

//Leave -> Arrive Section
Row leaveArrive() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Column(
        children: <Widget>[
          LeaveMenu(),

        ],
      ),
      Column(
        children: <Widget>[
          Container(
            height: 40.0,
            margin: EdgeInsets.only(left: 1.0, right: 1.0),
            child: Icon(Icons.arrow_forward, size: 30, color: Colors.black26),
          ),
        ],
      ),
      Column(
        children: <Widget>[
          ArriveMenu(),
        ],
      ),
      Column(
        children: <Widget>[
          Icon(
            Icons.youtube_searched_for,
            color: Colors.blueAccent,
          ),
        ],
      ),
    ],
  );
}

//Calendar Section
class _CalendarState extends State<CalendarSection> {
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(
              Icons.arrow_back_ios,
              color: Colors.black26,
              size: 20,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                    _dateTime == null
                        ? DateTime.now().month.toString()
                        : _dateTime.month.toString(),
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18)),
                Text('월'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                    _dateTime == null
                        ? DateTime.now().day.toString()
                        : _dateTime.day.toString(),
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18)),
                Text('일'),

              ],
            ),
          ],
          //text
          //text
        ),


        Column(
          children: <Widget>[
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black26,
              size: 20,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.calendar_today, color: Colors.blueAccent),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate:
                            _dateTime == null ? DateTime.now() : _dateTime,
                        firstDate: DateTime(DateTime.now().year - 5),
                        lastDate: DateTime(DateTime.now().year + 5))
                    .then((date) {
                  setState(() {
                    _dateTime = date;
                  });
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

//taxi all
class _TaxiListState extends State<TaxiList> {
  final Function onNext;

  _TaxiListState(this.onNext);

  List<Map<String, String>> datas = [];


  @override
  void initState() {
    super.initState();
    datas = [
      {
        "people": "assets/images/Final-oneblue.png",
        "time": "13:00",
        "leave": "한동대",
        "arrive": "커피유야",
      },
      {
        "people": "assets/images/Final-twoblue.png",
        "time": "19:00",
        "leave": "다이소",
        "arrive": "포항역",
      },
      {
        "people": "assets/images/Final-oneblue.png",
        "time": "10:00",
        "leave": "세차장",
        "arrive": "한동대",
      },
      {
        "people": "assets/images/Final-threeblue.png",
        "time": "12:00",
        "leave": "시외버스터미널",
        "arrive": "커피유야",
      },
      {
        "people": "assets/images/Final-fourblue.png",
        "time": "20:00",
        "leave": "한동대",
        "arrive": "육거리",
      },
    ];
  }

  Widget listWidget() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          // 주만: 카드형식으로 수정. (리스트 형식이랑 비교 후, 둘 중 하나로 통합)
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
          decoration: BoxDecoration(
            // border: Border.all(width: 1.0, color: Colors.black26),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 3,
                color: Colors.black12,
                offset: Offset(1.0, 3.0),
              ),
            ],
          ),
          child: InkWell(
            // 주만: tap 효과를 위해.
            onTap: () {
              // 하단 네비게이터 유지 x
              onNext(ChatScreen());

              // 하단 네비게이터 유지 o
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
            },
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        datas[index]["time"],
                        style: TextStyle(fontSize: 19),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Image.asset(
                          datas[index]["people"],
                          width: 40,
                          height: 40,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: Image.asset("assets/images/Final-fromto.gif"))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Text(datas[index]["leave"],
                          style: TextStyle(fontSize: 15)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Text(datas[index]["arrive"],
                          style: TextStyle(fontSize: 15)),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          // 주만: 구분선 삭제
          // height: 1,
          // color: Colors.black26,
        );
      },
      itemCount: 5,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            child: leaveArrive(),
          ),
          Container(
            child: CalendarSection(),
          ),
          Divider(
            color: Colors.black26,
            height: 30,
          ),
          // 주만: 기존의 SizedBox + height: 550 으로 처리되었던 부분을
          // 다양한 크기의 스크린에서의 호환성을 위해 Flexible로 변경
          Flexible(
            child: listWidget(),
          )
        ],
      ),
    );
  }
}

//carpool all
class _CarListState extends State<CarList> {
  final Function onNext;

  _CarListState(this.onNext);

  List<Map<String, String>> datas = [];


  @override
  void initState() {
    super.initState();
    datas = [
      {
        "people": "assets/images/Final-oneblue.png",
        "time": "13:00",
        "leave": "한동대",
        "arrive": "커피유야",
      },
      {
        "people": "assets/images/Final-twoblue.png",
        "time": "19:00",
        "leave": "다이소",
        "arrive": "포항역",
      },
      {
        "people": "assets/images/Final-oneblue.png",
        "time": "10:00",
        "leave": "세차장",
        "arrive": "한동대",
      },
      {
        "people": "assets/images/Final-threeblue.png",
        "time": "12:00",
        "leave": "시외버스터미널",
        "arrive": "커피유야",
      },
      {
        "people": "assets/images/Final-fourblue.png",
        "time": "20:00",
        "leave": "한동대",
        "arrive": "육거리",
      },
    ];
  }

  Widget listWidget() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          // 주만: 카드형식으로 수정. (리스트 형식이랑 비교 후, 둘 중 하나로 통합)
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
          decoration: BoxDecoration(
            // border: Border.all(width: 1.0, color: Colors.black26),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 3,
                color: Colors.black12,
                offset: Offset(1.0, 3.0),
              ),
            ],
          ),
          child: InkWell(
            // 주만: tap 효과를 위해.
            onTap: () {
              // 하단 네비게이터 유지 x
              onNext(ChatScreen());

              // 하단 네비게이터 유지 o
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
            },
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        datas[index]["time"],
                        style: TextStyle(fontSize: 19),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Image.asset(
                          datas[index]["people"],
                          width: 40,
                          height: 40,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: Image.asset("assets/images/Final-fromto.gif"))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Text(datas[index]["leave"],
                          style: TextStyle(fontSize: 15)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Text(datas[index]["arrive"],
                          style: TextStyle(fontSize: 15)),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          // 주만: 구분선 삭제
          // height: 1,
          // color: Colors.black26,
        );
      },
      itemCount: 5,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            child: leaveArrive(),
          ),
          Container(
            child: CalendarSection(),
          ),
          Divider(
            color: Colors.black26,
            height: 30,
          ),
          // 주만: 기존의 SizedBox + height: 550 으로 처리되었던 부분을
          // 다양한 크기의 스크린에서의 호환성을 위해 Flexible로 변경
          Flexible(
            child: listWidget(),
          )
        ],
      ),
    );
  }
}

//all
class _TaxiCarListState extends State<TaxiCarList> {
  final Function onNext;

  _TaxiCarListState(this.onNext);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: createTabBar(),
            backgroundColor: Colors.white,
            title: const Text(
              '조회 / 모집',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.blue,
                ),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => PlusPage()));
                },
              )
            ],
          ),
          body:
          TabBarView(
            children: <Widget>[
              TaxiList(onNext: onNext,),
              CarList(onNext: onNext),
              //Icon(Icons.drive_eta_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

//tab bar
TabBar createTabBar() {
  return TabBar(
    labelColor: Colors.black,
    labelPadding: EdgeInsets.all(10),
    tabs: [
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.local_taxi, color: Colors.blue), Text('택시')]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        // 주만: 난 왜 아이콘이 로드가 안되지... rounded는 안되고 이건 되서 컴파일 하려고 이거로 바꿔낌.
        Icon(Icons.drive_eta, color: Colors.blue),
        Text('카풀')
      ]),
    ],
  );
}
