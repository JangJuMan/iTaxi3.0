import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app/screen/pluspage.dart';

class TimeLine extends StatefulWidget {
  TimeLine({Key key}) : super(key: key);

  @override
  _TimeLineState createState() => _TimeLineState();
}

class RideLog extends StatefulWidget {
  RideLog({Key key}) : super(key: key);

  @override
  _RideLogState createState() => _RideLogState();
}

Widget RideSoon() {
  return Container(
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
                padding: EdgeInsets.only(left: 14.0),
                child: Image.asset(
                  Icon("assets/images/Final-fourblue"),
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
}



class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
          body: Container(
            child: Column(
              children: <Widget>[
                Text('곧 탑승 예정'),
                RideSoon(),
              ],
            )
          ),
          ),
    );
  }
}

class _RideLogState extends State<RideLog> {
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
