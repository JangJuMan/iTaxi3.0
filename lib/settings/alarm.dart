import 'package:flutter/material.dart';

// 주만: class 이름이라 제 편의대로(?) 대문자로 바꿨습니다. 나머지 파일두.
class Alarm extends StatelessWidget {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: Text ('알림', style: TextStyle(color: Colors.black),),
      ),
    );
  }
}