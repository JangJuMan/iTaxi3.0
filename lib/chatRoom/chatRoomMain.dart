import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // 테마
import 'package:flutter/cupertino.dart';  // 플랫폼별 버튼
import 'package:intl/intl.dart';          // Datetime format
import 'package:itaxi/main.dart';
import 'package:itaxi/themes.dart';       // 이거 임포트 경로가 다를 수 있음. 깃헙이름이 iTaxi 3.0이라서 내 로컬이랑 다를수도..

import 'package:http/http.dart' as http;  // 네트워크 통신 테스트
import 'dart:async';
import 'dart:convert';

// TODO: 제한된 개수로 채팅 불러오기
// TODO: 이전 기록이 같은 사람이면 텍스트만 보이게하기
// TODO: 이전 기록이 같은 시간이면 아래 시간만 보이게하기
// TODO: 뒤로가기 버튼?

// Widget > Component > Element

String _name = "장주만";

// Class: 채팅방 정보
class ChatRoomInfo {
  // TODO: 나중엔 속성에 맞게 수정 필요
  final int userId;
  final int id;
  final String title;

  ChatRoomInfo({this.userId, this.id, this.title});

  factory ChatRoomInfo.fromJson(Map<String, dynamic> json) {
    return ChatRoomInfo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

// Class: 채팅 내용
class ChatMessage extends StatelessWidget {
  final String content;
  final String date_time;
  final String user_name;
  // final List<String> read;
  final bool is_chat;

  ChatMessage({this.content, this.date_time, this.user_name, /*this.read,*/ this.is_chat});

  @override
  Widget build(BuildContext context) {
    if(is_chat){
      if(user_name == _name){     // 내가 보낸 메시지
        return _myChat(context);
      }
      else{       // 상대가 보낸 메시지
        return _othersChat(context);
      }
    }
    else{
      return _systemChat(context);
    }
  }

  // Widget: 내가 보낸 채팅
  Widget _myChat(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  user_name,
                  style: Theme.of(context).textTheme.headline6,             // subtitle1
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(date_time),
                      ),
                      Flexible(
                        child:  Container(
                          margin: EdgeInsets.only(left: 10.0),
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(content, style: TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: CircleAvatar(child: Text(user_name[0] /*user_name.substring(0, 2)*/)),
          ),
        ],
      ),
    );
  }

  // Widget: 상대가 보낸 채팅
  Widget _othersChat(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: Text(user_name[0])),
          ),
          // 긴 Text 줄 바꿈
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user_name,
                  style: Theme.of(context).textTheme.headline6,             // subtitle1
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child:  Container(
                          margin: EdgeInsets.only(right: 10.0),
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.3),
                            color: Color.fromRGBO(0xFF, 0xFF, 0xFF, 1),
                            // color: Color.fromRGBO(0x3F, 0xA9, 0xF5, 0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Text(content, style: TextStyle(fontSize: 15)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20.0),
                        child: Text(date_time, style: TextStyle(fontSize: 11)
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget: 시스템 메시지
  Widget _systemChat(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 3.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                  child: Text(
                      content,
                      style: TextStyle(fontSize: 14,)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Class: 채팅 리스트 (지금 안씀)
class ChatList extends StatelessWidget{
  final List<ChatMessage> chats;

  ChatList({Key key, this.chats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      reverse: true,
      itemBuilder: (context, int index) => chats[index],
      itemCount: chats.length,
    );
  }


}

// Method: 채팅방 정보 받아오기.
Future<ChatRoomInfo> fetchChatRoomInfo() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if(response.statusCode == 200){
    return ChatRoomInfo.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception('Failed to load ChatRoomInfo');
  }
}




// 채팅방 메인
// class ChatRoomMain extends StatelessWidget {
//   const ChatRoomMain({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
//
//       // home: 기본화면 지정
//       home: ChatScreen(),
//     );
//   }
// }

class ChatScreen extends StatefulWidget{
  @override
  State createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  String roomTitle = "채팅방 제목 placeholder";
  Future<ChatRoomInfo> futureChatRoomInfo;

  // 텍스트 컨트롤러 객체
  final _textController = TextEditingController();
  // 채팅기록을 담은 리스트
  final List<ChatMessage> _messages = [];
  // 메시지 입력 후 TextField에 다시 포커싱 담당
  final FocusNode _focusNode = FocusNode();
  // 사용자가 입력중인가?
  bool _isWriting = false;
  // 사용자 정보 확장 변수
  bool _isVisible01 = true;
  bool _isVisible02 = true;
  bool _isVisible03 = true;
  bool _isVisible04 = true;


  // 스크롤 컨트롤러 객체
  ScrollController _scrollController = new ScrollController();



  // 최초 1번만 데이터 로드할 때,
  @override
  void initState() {
    super.initState();
    futureChatRoomInfo = fetchChatRoomInfo();
    // futureAlbum = fetchAlbum();

    // FOR DEBUG
    var nowTime = DateFormat('HH:mm').format(DateTime.now());

    for(int i=0; i<5; i++) {
      // 메시지 리스트에 사용자가 보낸 메시지를 .insert(index, element)
      ChatMessage inputMessage = ChatMessage(
        content: "샘플메시지입니다." + i.toString(),
        date_time: nowTime,
        user_name: "상대방",
        is_chat: true,
      );

      setState(() {
        _messages.insert(0, inputMessage);
      });
    }

    // FOR DEBUG
    for(int i=5; i<7; i++) {
      // 메시지 리스트에 사용자가 보낸 메시지를 .insert(index, element)
      ChatMessage inputMessage = ChatMessage(
        content: "시스템 안내 메시지 입니다." + i.toString(),
        date_time: nowTime,
        user_name: "시스템",
        is_chat: false,
      );

      setState(() {
        _messages.insert(0, inputMessage);
      });
    }

    // FOR DEBUG
    for(int i=7; i<10; i++) {
      // 메시지 리스트에 사용자가 보낸 메시지를 .insert(index, element)
      ChatMessage inputMessage = ChatMessage(
        content: "내가보낸 메시지 입니다." + i.toString(),
        date_time: nowTime,
        user_name: _name,
        is_chat: true,
      );

      setState(() {
        _messages.insert(0, inputMessage);
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        // TODO: 나중에 setState로 ??? 방장? 이런식으로 제목 바꾸기
        title: Text(roomTitle),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Center(
        child: FutureBuilder<ChatRoomInfo>(
          future: futureChatRoomInfo,
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Text('${snapshot.error}');
            }
            return snapshot.hasData ? _wid_chatScreen(snapshot) : CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  // Widget: 채팅방 스크린
  // ignore: non_constant_identifier_names
  Widget _wid_chatScreen([AsyncSnapshot<ChatRoomInfo> snapshot]) {
    // snapshot 데이터 파싱 (TODO: 나중에 수정)
    int id = snapshot.data.id;
    int userId = snapshot.data.userId;
    String title = snapshot.data.title;

    return Container(
      child: Column(
        children: [
          // 채팅방 정보
          Container(
            child: _wid_roomInfo(
              departure_place: title,
              arrival_place: title,
              departure_date: id.toString(),
              depature_time: userId.toString()
            ),
          ),

          // 채팅기록
          Flexible(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (context, int index) => _messages[index],
              itemCount: _messages.length,
            ),
            // ChatList(),
          ),

          // 디바이더
          Divider(height: 1.0),

          // 채팅 입력창
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor),
            child: _wid_textInput(),
          ),
        ],
      ),
      decoration: Theme.of(context).platform == TargetPlatform.iOS
          ? BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey[200]),
            ),
          )
          : null
    );
  }


  // Widget: 채팅방 정보
  // ignore: non_constant_identifier_names
  Widget _wid_roomInfo({String departure_place, String arrival_place, String departure_date, String depature_time}){
    // 기본값 설정
    departure_place ??= "";
    arrival_place ??= "";
    departure_date ??= "";
    depature_time ??= "";

    return Container(
      child: Column(
        children: [
          _cmp_roomInfo(
            departure_place: departure_place,
            arrival_place: arrival_place,
            departure_date: departure_date,
            depature_time: depature_time
          ),
          _cmp_participantInfo(),
        ],
      ),
    );
  }

  // Component: 방정보
  // ignore: non_constant_identifier_names
  Container _cmp_roomInfo({String departure_place, String arrival_place, String departure_date, String depature_time}){

    return Container(
      padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 7.0),

      decoration: BoxDecoration(
        border: Border(
          // bottom: BorderSide(width: 1.0, color: Colors.black26),
        ),
        color: Color.fromRGBO(0xF5, 0xF5, 0xF5, 1),
      ),

      child: Row(
        children: [
          Flexible(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(2.0),
                  margin: EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Text(departure_place, style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2.0),
                  margin: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.arrow_forward),
                      Text(" "+arrival_place, style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2.0),
                  margin: EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Icon(Icons.departure_board, size: 20),
                      Text(" "+departure_date+"  "+depature_time, style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 10.0),
            child: Column(
              children: [
                Theme.of(context).platform == TargetPlatform.iOS
                    ? CupertinoButton(
                      child: Text(
                        '방 나가기',
                        style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () => {},
                    )
                    : RaisedButton(
                      child: Text('방 나가기', style: TextStyle(color: Colors.white)),
                      color: Colors.redAccent,
                      onPressed: () => {},
                    ),
                // TODO: 방장한테만 보이기, (상관없나?)
                Theme.of(context).platform == TargetPlatform.iOS
                    ? CupertinoButton(
                      child: Text(
                        '정산하기',
                        style: TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () => {},
                    )
                    : RaisedButton(
                      child: Text('정산하기', style: TextStyle(color: Colors.white)),
                      color: Colors.indigoAccent,
                      onPressed: () => {},
                    ),
              ],
            ),
          ),
        ],
      )
    );
  }


  // Component: 참가자 리스트
  // ignore: non_constant_identifier_names
  Container _cmp_participantInfo(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
        border: Border(
          // bottom: BorderSide(width: 1.0, color: Colors.black26),
        ),
        color: Colors.black12,
      ),
      // 컨테이너의 높이를 설정
      height: 55.0,
      // 리스트뷰 추가
      child: ListView(
        // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
        scrollDirection: Axis.horizontal,
        // 컨테이너들을 ListView의 자식들로 추가
        children: [
          // TODO: 반복문... 안써도 되나?
          _elem_participantUnit('장주만', 1, _isVisible01),
          _elem_participantUnit('홍길참', 2, _isVisible02),
          _elem_participantUnit('김참길', 3, _isVisible03),
          _elem_participantUnit('고베어', 4, _isVisible04),
        ],
      ),
    );
  }

  // Element: 참가자 정보 유닛
  // ignore: non_constant_identifier_names
  Container _elem_participantUnit(name, btnNumber, bool isVisible){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.cyan),
        borderRadius: BorderRadius.circular(30.0),
        color: Color.fromRGBO(0xF5, 0xF5, 0xF5, 1),
      ),
      child: Row(
        children: [
          IconButton(
            iconSize: 60,
            icon: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                // border: Border.all(width: 1.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            onPressed: () {
              setState(() {
                if(btnNumber == 1){
                  _isVisible01 = !_isVisible01;
                }
                else if(btnNumber == 2){
                  _isVisible02 = !_isVisible02;
                }
                else if(btnNumber == 3){
                  _isVisible03 = !_isVisible03;
                }
                else if(btnNumber == 4){
                  _isVisible04 = !_isVisible04;
                }
              });
            },
          ),
          Visibility(
            visible: isVisible,
            child: IconButton(
                icon: Icon(Icons.call, size: 20),
                // TODO: 전화연결
                onPressed: () => {}
            ),
          ),
          Visibility(
            visible: isVisible,
            child: IconButton(
                icon: Icon(Icons.message, size: 20),
                // TODO: 문자 보내기
                onPressed: () => {}
            ),
          ),
        ],
      ),
    );
  }




  // Widget: 텍스트 입력
  // ignore: non_constant_identifier_names
  Widget _wid_textInput(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onChanged: (String text){
                setState(() {
                  _isWriting = text.length > 0;
                });
              },
              onSubmitted: _isWriting ? _handleSubmitted : null,
              decoration: InputDecoration.collapsed(hintText: "보낼 메시지를 입력하세요"),
              focusNode: _focusNode,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? CupertinoButton(
                  child: Text('보내기'),
                  onPressed: _isWriting ? () => _handleSubmitted(_textController.text) : null)
                : IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isWriting ? () => _handleSubmitted(_textController.text) : null)
          ),
        ],
      ),
    );
  }


  // Method: 채팅 보내기 클릭시 실행
  void _handleSubmitted(String text){
    // 텍스트 필드 비우기
    _textController.clear();

    // 텍스트 작성중 --> false
    setState(() {
      _isWriting = false;
    });

    // 메시지 리스트에 사용자가 보낸 메시지를 .insert(index, element)
    var nowTime = DateFormat('HH:mm').format(DateTime.now());

    ChatMessage inputMessage = ChatMessage(
      content: text,
      date_time: nowTime,
      user_name: _name,
      is_chat: true,
    );

    setState(() {
      _messages.insert(0, inputMessage);
    });

    // TextField에 다시 입력 포커스
    _focusNode.requestFocus();

    // 맨 아래로 스크롤
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );

  }
}