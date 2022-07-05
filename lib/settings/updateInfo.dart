import 'package:flutter/material.dart';


class UpdateInfo extends StatelessWidget {

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: Text ('공지사항', style: TextStyle(color: Colors.black),),
      ),
      body: ListView(
          children: [
            _InfoList('2021.02.08', '아이택시 새 버전'),
            _InfoList('2021.02.09', '새 버전 사용 방법'),
        ]
      )
    );
  }
}

Widget _InfoList(text1, text2) {
  // return ListTile(
  //   contentPadding: EdgeInsets.only(top:10, left: 20),
  //   subtitle: Text(text1, style: TextStyle(fontSize: 13, color: Colors.blue),),
  //   title: Text(text2, style: TextStyle(fontSize: 20, color: Colors.black),),
  // );
  return ExpansionTile(
    title: Text(text2, style: TextStyle(fontSize: 20, color: Colors.black),),
    initiallyExpanded: true, // 처음 들어왔을 때 펼칠 지 말 지
    subtitle: Text(text1, style: TextStyle(fontSize: 13, color: Colors.blue),),
    tilePadding: EdgeInsets.only(top:10, left: 20),
    children: [
      Divider(height: 3, color: Colors.grey,),
      Container(
        child: Text("세부 내용"),
      )
    ],

  );
}


