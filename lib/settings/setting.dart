import 'package:flutter/material.dart';
import 'alarm.dart';
import 'bug.dart';
import 'detailNotice.dart';
import 'myInfo.dart';
import 'termsOfService.dart';
import 'updateInfo.dart';
import 'version.dart';
import 'logout.dart';

class SettingPage extends StatelessWidget {
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
          // IconButton(
          //   icon: Icon(Icons.logout),
          // )
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
          // leading: Icon(Icons.notes_rounded),
          title: Text('공지사항',
              style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UpdateInfo()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.person_pin),
          title: Text('내정보',
              style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyInfo()),
            );
          },
        ),
        ListTile(
          // leading: Icon(Icons.privacy_tip_rounded),
          title: Text('버전정보/개발자',
              style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Version()),
            );
          },
        ),
        ListTile(
            leading: Icon(Icons.access_alarm),
            title: Text('알림',
                style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Alarm())
              );
            }
        ),
        ListTile(
            // leading: Icon(Icons.bug_report_outlined),
            title: Text('버그제보',
                style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Bug())
              );
            }
        ),
        ListTile(
            leading: Icon(Icons.lock),
            title: Text('이용약관',
                style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermsOfService())
              );
            }
        ),
      ],
    ).toList(),
  );
}
