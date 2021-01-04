import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // 테마
import 'package:flutter/cupertino.dart';  // 플랫폼별 버튼
import 'package:itaxi/themes.dart';       // 이거 임포트 경로가 다를 수 있음. 깃헙이름이 iTaxi 3.0이라서 내 로컬이랑 다를수도..

// TODO: 애니메이션 비활성화
// TODO: 제한된 개수로 채팅 불러오기
// TODO: 리스트에 미리 값 넣어보기
// TODO: 채팅 기록에 시간정보 남기기
// TODO: 이전 기록이 같은 사람이면 텍스트만 보이게하기
// TODO: 이전 기록이 같은 시간이면 아래 시간만 보이게하기
// TODO: 뒤로가기 버튼?

// 스크린 > 위젯 > 컴포넌트 > 엘리먼트

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




  // (위젯)채팅방 정보
  Widget ChatRoomInfo(){
    return Container(
      child: Column(
        children: [
          _comp_roomInfo(),
          _comp_participantInfo(),
        ],
      ),
    );
  }

  // (컴포넌트)방정보
  Container _comp_roomInfo(){
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
                      Text(" 시외버스터미널", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2.0),
                  margin: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, size: 20),
                      Text("  한동대학교", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2.0),
                  margin: EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Icon(Icons.departure_board, size: 20),
                      Text(" 01월 23일  17:20", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                Theme.of(context).platform == TargetPlatform.iOS
                    ? CupertinoButton(
                      child: Text(
                        '정산하기',
                        style: TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.w600),
                      ),
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

  // (컴포넌트)참가자 리스트
  Container _comp_participantInfo(){
    return Container(
      decoration: BoxDecoration(
        border: Border(
          // bottom: BorderSide(width: 1.0, color: Colors.black26),
        ),
        color: Colors.black12,
      ),
      // 컨테이너의 높이를 55로 설정
      height: 60.0,
      // 리스트뷰 추가
      child: ListView(
        // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
        scrollDirection: Axis.horizontal,
        // 컨테이너들을 ListView의 자식들로 추가
        children: [
          // TODO: 반복문
          _elem_participantUnit(_name),
          _elem_participantUnit('홍길참'),
          _elem_participantUnit('김참길'),
          _elem_participantUnit('고베어'),
        ],
      ),
    );
  }

  // (엘리먼트)참가자 정보 유닛
  Container _elem_participantUnit(name){
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
            padding: EdgeInsets.all(0),
            icon: CircleAvatar(child: Text(name[1] + name[2])),
            // TODO: onPressed 할 때, 확장 및 축소
            onPressed: () => {},
          ),
          IconButton(
              icon: Icon(Icons.call, size: 20),
              onPressed: () => {}
          ),
          IconButton(
              icon: Icon(Icons.message, size: 20),
              onPressed: () => {}
          ),
        ],
      ),
    );
  }

  //========================================================================================================================

  // (위젯)텍스트 입력 위
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



  // 빌드 및 랜더링
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
                child: ChatRoomInfo(),
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
String _name = "장주만";

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