import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // 테마
import 'package:flutter/cupertino.dart';  // 플랫폼별 버튼
import 'package:itaxi/themes.dart';


// [채팅방 메인]
class ChatRoomMain extends StatelessWidget {
  const ChatRoomMain({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'material app title',
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,

      // home: 기본화면 지정
      home: ChatScreen(),
    );
  }
}

// [stateful 채팅방]
class ChatScreen extends StatefulWidget{
  @override
  State createState() => _ChatScreenState();
}


// [채팅방 컨텐츠]
class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{
  // 텍스트 컨트롤러 객체
  final _textController = TextEditingController();
  // 채팅 기록을 담은 리스트
  final List<ChatMessage> _messages = [];

  // 메시지 입력후 TextField 다시 포커싱 담당
  final FocusNode _focusNode = FocusNode();
  // 사용자가 입력중인가?
  bool _isComposing = false;


  // 채팅 보내기 클릭시 담당 매서드
  void _handleSubmitted(String text){
    // 텍스트 필드 비우기
    _textController.clear();

    // 텍스트 작성중? -> false
    setState(() {
      _isComposing = false;
    });

    // 메시지 리스트에 사용자가 보낸 메시지를 .insert(index, element)
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 300),
        // 수직동기화
        vsync: this,
      ),
    );

    setState(() {
      _messages.insert(0, message);
    });

    // TextField 에 다시 입력 포커스
    _focusNode.requestFocus();

    // 애니메이션 작동
    message.animationController.forward();
  }


  // 리소스 확보를 위해 애니메이션 폐기 매서드
  @override
  void dispose(){
    for(ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }







  // 채팅방 정보 위젯 ========================================================================================================================
  Widget _chatRoomInfo(){
    return Container(
      child: Column(
        children: [
          _roomInfo(),
          _participantInfo(),
        ],
      ),
    );
  }

  // 방정보
  Widget _roomInfo(){
    return Container(
      // 디버깅용
        decoration: BoxDecoration(
          // border: Border.all(width: 1.0, color: Color(0xFF3FA9F5)),
          color: Color.fromRGBO(0xF5, 0xF5, 0xF5, 1),
          // color: Color.fromRGBO(0x3F, 0xA9, 0xF5, 0.5),
        ),

        margin: EdgeInsets.all(0.0),
        padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 7.0),
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.0),
                    margin: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.redAccent)
                    ),
                    child: Row(
                      children: [
                        Text(" 시외버스터미널", style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2.0),
                    margin: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.redAccent)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow, size: 20),
                        Text("  한동대학교", style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2.0),
                    margin: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.redAccent)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.departure_board, size: 20),
                        Text(" 2020년 01월 23일  17:20", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.redAccent)
              ),
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
                    child: Text('방 나가기'),
                    onPressed: () => {},
                  ),
                  // TODO: 방장한테만 보이기, (상관없나?)
                  // TODO: 버튼 스타일 보여주려고 지금은 != 로 해놓음. 나중에 바꿔야함.
                  Theme.of(context).platform != TargetPlatform.iOS
                      ? CupertinoButton(
                    child: Text('정산하기'),
                    onPressed: () => {},
                  )
                      : RaisedButton(
                    child: Text('정산하기'),
                    onPressed: () => {},
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }

  Widget _participantInfo(){
    return Container(
      child: Row(
        children: [
          Text("참여자 정보"),
        ],
      ),
    );
  }

  //========================================================================================================================

  // 텍스트 입력 위젯
  Widget _buildTextComposer(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (String text){
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _isComposing ? _handleSubmitted : null,
                decoration: InputDecoration.collapsed(hintText: "보낼 메시지를 입력하세요"),
                focusNode: _focusNode,
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? CupertinoButton(
                  child: Text('보내기'),
                  onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null,
                )
                    : IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null,
                )
            ),
          ],
        )
    );
  }



  // 빌드 및 랜더링 위젯
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ('채팅방 제목'),
        // appbar 의 z좌표. 4.0: 그림자 O, 0.0: 그림자 X
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
          child: Column(
            children: [
              // 채팅방 정보
              Container(
                child: _chatRoomInfo(),
              ),
              // 채팅기록
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                ),
              ),
              // 디바이더
              Divider(height: 1.0),
              // 채팅 입력창
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
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
      ),
    );
  }
}




// [임시 이름 변수]
String _name = "Name from DB";

// [채팅 기록 말풍선]
class ChatMessage extends StatelessWidget{
  ChatMessage({this.text, this.animationController});

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      // 애니메이션 추가
      sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut
      ),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Text(_name[0])),
            ),
            // 긴 Text 줄 바꿈
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      _name,
                      style: Theme.of(context).textTheme.headline6,             // subtitle1
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 15,
                      )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}