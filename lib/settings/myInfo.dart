import 'package:flutter/material.dart';
import 'remyInfo.dart';

class MyInfo extends StatelessWidget {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text ('내정보'),
      ),
      body:
          Column(
            children: <Widget> [
            _Profile(),
             Container(
               child: Container(
                child: Row(
                  children: <Widget> [
                    Padding(
                      padding: EdgeInsets.only(top:100, left: 150),
                    ),
                    RaisedButton(
                      child: Text('개인정보 수정'),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => RemyInfo(),
                          )
                        )
                      },
                    )
                  ],
                )
               )
             )
            ]
             )
          );
  }
}

 Widget _Profile() {
  return Container(
    child : Container(
      child: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 30, top: 40),
               child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _InfoMenu("학번"),
                  _InfoMenu("한글 이름"),
                  _InfoMenu("영어 이름"),
                  _InfoMenu("휴대폰 번호"),
                  _InfoMenu("Email"),
                  _InfoMenu("계좌 은행"),
                  _InfoMenu("계좌 번호"),
                ]
               )
        ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 35, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _Info("22000019"),
                    _Info("강희영"),
                    _Info("Kang, Hyiyoung"),
                    _Info("010-7385-1416"),
                    _Info("hkdislat@naver.com"),
                    _Info("기업"),
                    _Info("01073851416"),
                  ],
                )
              )
            ],
          ),
        ]
      )
      )
    );
}

Widget _InfoMenu(text){
  return Padding(
    padding: EdgeInsets.only(top:15, left: 20),
    child: Text(text, style: TextStyle(fontSize: 20, height: 1.5, color: Colors.grey))
  );
}

Widget _Info(text){
  return Padding(
      padding: EdgeInsets.only(top:15, left: 20),
      child: Text(text, style: TextStyle(fontSize: 20, height: 1.5))
  );
}

