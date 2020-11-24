import 'package:flutter/material.dart';
import 'alarm.dart';
import 'bug.dart';
import 'detailNotice.dart';
import 'myinfo.dart';
import 'termsOfservice.dart';
import 'updateInfo.dart';
import 'version.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHomePage(
          title: '설정',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title,
        style: TextStyle(fontSize: 35)
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check_circle),
          )
        ],
      ),
      body: BodyLayout(),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context) {
  return ListView(
    children: ListTile.divideTiles(
        context: context,
        tiles: [
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('공지사항',
            style: TextStyle(fontSize: 20)),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => updateInfo()),
              );
            },
          ),
          ListTile(
            title: Text('내정보'),
          ),
          ListTile(
            title: Text('버전정보/개발자'),
          ),
          ListTile(
            title: Text('알림'),
          ),
          ListTile(
            title: Text('버그제보'),
          ),
          ListTile(
            title: Text('이용약관'),
          ),
      ],
    ).toList(),
  );
}
