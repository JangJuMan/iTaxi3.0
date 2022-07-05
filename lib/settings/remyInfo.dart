import 'package:flutter/material.dart';

class RemyInfo extends StatelessWidget {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: Text ('개인정보 수정'),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Column(children: [
                    NewInfo('StudentID(학번)', '학번을 적어주세요'),
                    NewInfo('Korean Name(한글 이름)', '한글 이름을 적어주세요'),
                    NewInfo('English Name(영어 이름)', '영어 이름을 적어주세요'),
                    NewInfo('Phone Number(휴대폰 번호)', '휴대폰 번호를 적어주세요'),
                    NewInfo('Email', '이메일을 적어주세요'),
                    NewInfo('Account Bank Name(계좌 은행)', '은행을 적어주세요'),
                    NewInfo('Account Number(계좌 번호)', '계좌번호를 적어주세요'),
                  ],),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 30, right: 30),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('변경하기', style: TextStyle(color: Colors.black, fontSize: 16),)
                  ),
                )
              ],
            )
          )
        ],
      )
    );
  }
}

NewInfo(text1, text2) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(top: 5),
        child: Text(text1, style: TextStyle(color: Colors.black),),
      ),
      TextField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: text2,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
        )
      )
    ],
  );
}