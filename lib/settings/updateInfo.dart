import 'package:flutter/material.dart';


class UpdateInfo extends StatelessWidget {

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ('공지사항'),
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
  return ListTile(
    contentPadding: EdgeInsets.only(top:10, left: 20),
    subtitle: Text(text1, style: TextStyle(fontSize: 13, color: Colors.blue),),
    title: Text(text2, style: TextStyle(fontSize: 20, color: Colors.black),),
  );
}


