import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/screen/pluspage.dart';

class TimeLine extends StatefulWidget {
  TimeLine({Key key}) : super(key: key);

  @override
  _TimeLineState createState() => _TimeLineState();
}

Widget listWidget() {
  return  Container(
    margin: EdgeInsets.all(20),
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.black26),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
              spreadRadius: 4,
              blurRadius: 7,
              color: Colors.black12

          ),
        ]
    ),
    child: Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '13:00',
                  style: TextStyle(fontSize: 19),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14.0, top: 10.0),
                  child: Image.asset("assets/images/Final-fourblue.png",
                    width: 40,
                    height: 40,
                  ),
                ),
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
                child: Text("커피유야",
                    style: TextStyle(fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text("포항역",
                    style: TextStyle(fontSize: 15)),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget RideSoon() {
  return Container(
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 15,
            left: 20,
          ),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '곧 탑승 예정',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.blueAccent),
          ),
          child: Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '13:00',
                        style: TextStyle(fontSize: 19),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 14.0, top: 10.0),
                        child: Image.asset(
                          "assets/images/Final-fourblue.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
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
                      child: Text("커피유야", style: TextStyle(fontSize: 15)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Text("포항역", style: TextStyle(fontSize: 15)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget RideLog() {
  DateTime now =  DateTime.now();
  DateTime before = now.subtract(Duration(days: 1));
  var day = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
  var when = now.weekday;


  return Container(
    child: Column(
      children: <Widget>[
        Row (
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 15)),
              Text('${now.month.toString()}월 ${now.day.toString()}일 ', style: TextStyle(color: Colors.black54, fontSize: 14)),
              Text(day[when-1], style: TextStyle(color: Colors.black54, fontSize: 14)),
            ]
        ),
        listWidget(),
        Divider(color: Colors.black26,),

        Row (
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 15)),
              Text('${now.subtract(Duration(days: 1)).month.toString()}월 ${now.subtract(Duration(days: 1)).day.toString()}일 ', style: TextStyle(color: Colors.black54, fontSize: 14)),
              Text(day[before.weekday-1], style: TextStyle(color: Colors.black54, fontSize: 14)),
            ]
        ),
        listWidget(),
        Divider(color: Colors.black26,),
      ]
    ),
  );
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            '타임라인',
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
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                RideSoon(),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    left: 20,
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '탑승 내역',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 20,
                ),

                RideLog(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
