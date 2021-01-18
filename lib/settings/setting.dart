import 'package:flutter/material.dart';
import 'package:itaxi/chatRoom/chatRoomMain.dart';
import 'alarm.dart';
import 'bug.dart';
import 'detailNotice.dart';
import 'myInfo.dart';
import 'termsOfService.dart';
import 'updateInfo.dart';
import 'version.dart';
import 'logout.dart';

// 세팅 페이지 이름좀 바꿨습니다. (MyHomePage --> Settings)
// class SettingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '',
//       theme: ThemeData(
//         primaryColor: Colors.white,
//       ),
//       home: Settings(
//         title: '설정',
//       ),
//     );
//   }
// }

class Settings extends StatefulWidget {
  final Function onNext;

  const Settings({Key key, this.onNext}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState(onNext);
}

class _SettingsState extends State<Settings> {
  final Function onNext;

  _SettingsState(this.onNext);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('설정',),
        actions: [
          // TODO: 아이콘이 로드가 안되서 그냥 보이는거 아무거나 넣었습니다.
          // IconButton(
          //   icon: Icon(Icons.logout),
          // )
          IconButton(
            icon: Icon(Icons.replay),
          )
        ],
      ),
      body: _myListView(),
    );
  }

  Widget _myListView(){
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          // 아이콘 내맘대로 한거임 바꿔도 됨!
          _comp_listTile(Icons.event_note, '공지사항', UpdateInfo()),
          _comp_listTile(Icons.person_pin, '내정보', MyInfo()),
          _comp_listTile(Icons.developer_mode, '버전정보/개발자', Version()),
          _comp_listTile(Icons.access_alarm, '알림', Alarm()),
          _comp_listTile(Icons.bug_report, '버그제보', Bug()),
          _comp_listTile(Icons.lock, '이용약관', TermsOfService()),
        ],
      ).toList(),
    );
  }

  // ignore: non_constant_identifier_names
  ListTile _comp_listTile(icon, text, next){
    return ListTile(
        leading: Icon(icon),
        title: Text(text, style: TextStyle(fontSize: 20)),
        onTap: () {
          // 하단 네비게이터 없게 하기
          onNext(next);
        }
    );
  }
}



// class BodyLayout extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _myListView(context);
//   }
// }
//
// Widget _myListView(BuildContext context) {
//   return ListView(
//     children: ListTile.divideTiles(
//       context: context,
//       tiles: [
//         ListTile(
//           // leading: Icon(Icons.notes_rounded),
//           title: Text('공지사항',
//               style: TextStyle(fontSize: 20)),
//           onTap: () {
//             // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
//             // Navigator.pushNamed(context, 'UpdateInfo');
//
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => UpdateInfo()),
//             );
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.person_pin),
//           title: Text('내정보',
//               style: TextStyle(fontSize: 20)),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => MyInfo()),
//             );
//           },
//         ),
//         ListTile(
//           // leading: Icon(Icons.privacy_tip_rounded),
//           title: Text('버전정보/개발자',
//               style: TextStyle(fontSize: 20)),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Version()),
//             );
//           },
//         ),
//         ListTile(
//             leading: Icon(Icons.access_alarm),
//             title: Text('알림',
//                 style: TextStyle(fontSize: 20)),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Alarm())
//               );
//             }
//         ),
//         ListTile(
//             leading: Icon(Icons.bug_report),
//             // leading: Icon(Icons.bug_report_outlined),
//             title: Text('버그제보',
//                 style: TextStyle(fontSize: 20)),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Bug())
//               );
//             }
//         ),
//         ListTile(
//             leading: Icon(Icons.lock),
//             title: Text('이용약관',
//                 style: TextStyle(fontSize: 20)),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => TermsOfService())
//               );
//             }
//         ),
//       ],
//     ).toList(),
//   );
// }
