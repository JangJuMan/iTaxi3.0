import 'package:flutter/material.dart';
import 'package:my_app/screen/plus.dart';
import 'package:flutter/cupertino.dart';

class TaxiCarList extends StatefulWidget {
  TaxiCarList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TaxiCarListState createState() => _TaxiCarListState();
}

class TaxiList extends StatefulWidget {
  TaxiList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TaxiListState createState() => _TaxiListState();
}

class CarList extends StatefulWidget {
  CarList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CarListState createState() => _CarListState();
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
      icon: Icon(Icons.arrow_drop_down_outlined),
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
      icon: Icon(Icons.arrow_drop_down_outlined),
      iconEnabledColor: Colors.black26,
      iconSize: 25,
      elevation: 12,
      style: TextStyle(color: Colors.black),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['한동대', '커피유야', '다이소', '세차장', '포항역','직접입력']
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
          Icon(Icons.youtube_searched_for, color: Colors.blueAccent,),
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
           Icon(Icons.arrow_back_ios, color: Colors.black26, size: 20,),
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(_dateTime == null ? DateTime.now().month.toString(): _dateTime.month.toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 18)),
                Text('월'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(_dateTime == null? DateTime.now().day.toString(): _dateTime.day.toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 18)),
                Text('일'),
              ],
            ),
          ],
          //text
          //text
        ),
        Column(
          children: <Widget>[
            Icon(Icons.arrow_forward_ios, color: Colors.black26, size: 20,),
          ],
        ),
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.calendar_today, color: Colors.blueAccent),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime(DateTime.now().year-5),
                  lastDate: DateTime(DateTime.now().year+5)
                ).then((date) {
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
  List<Map<String, String>> datas = [];
  @override
  void initState() {
    super.initState();
    datas = [
      {
        "people": "assets/image/Final-oneblue.png",
        "time": "13:00",
        "leave": "한동대",
        "arrive": "커피유야",
      },
      {
        "people": "assets/image/Final-twoblue.png",
        "time": "19:00",
        "leave": "다이소",
        "arrive": "포항역",
      },
      {
        "people": "assets/image/Final-oneblue.png",
        "time": "10:00",
        "leave": "세차장",
        "arrive": "한동대",
      },
      {
        "people": "assets/image/Final-threeblue.png",
        "time": "12:00",
        "leave": "시외버스터미널",
        "arrive": "커피유야",
      },
      {
        "people": "assets/image/Final-fourblue.png",
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
                      child: Image.asset("assets/image/Final-fromto.gif"))
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
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: Colors.black26,
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
            SizedBox(
              height: 550.0,
              child: listWidget(),
            )
      ],
      ),
    );
  }
}

//carpool all
class _CarListState extends State<CarList> {
  List<Map<String, String>> datas = [];
  @override
  void initState() {
    super.initState();
    datas = [
      {
        "people": "assets/image/Final-oneblue.png",
        "time": "13:00",
        "leave": "한동대",
        "arrive": "커피유야",
      },
      {
        "people": "assets/image/Final-twoblue.png",
        "time": "19:00",
        "leave": "다이소",
        "arrive": "포항역",
      },
      {
        "people": "assets/image/Final-oneblue.png",
        "time": "10:00",
        "leave": "세차장",
        "arrive": "한동대",
      },
      {
        "people": "assets/image/Final-threeblue.png",
        "time": "12:00",
        "leave": "시외버스터미널",
        "arrive": "커피유야",
      },
      {
        "people": "assets/image/Final-fourblue.png",
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
                      child: Image.asset("assets/image/Final-fromto.gif"))
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
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: Colors.black26,
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
          SizedBox(
            height: 550.0,
            child: listWidget(),
          )
        ],
      ),
    );
  }
}

//all
class _TaxiCarListState extends State<TaxiCarList> {
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
          body: TabBarView(
            children: <Widget>[
              TaxiList(),
              CarList(),
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
        Icon(Icons.drive_eta_rounded, color: Colors.blue),
        Text('카풀')
      ]),
    ],
  );
}

