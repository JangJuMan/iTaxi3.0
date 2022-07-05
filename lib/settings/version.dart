import 'package:flutter/material.dart';

class Version extends StatelessWidget {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: Text ('버전정보', style: TextStyle(color: Colors.black),),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Image.asset("assets/images/FinalMainLogo.png"),
                  ),
                  Text("최신 버전을 사용 중입니다", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold )),
                  Text("현재 버전 3.0", style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      )
    );
  }
}