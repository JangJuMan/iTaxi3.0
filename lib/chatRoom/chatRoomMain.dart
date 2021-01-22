import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // 테마
import 'package:flutter/cupertino.dart';  // 플랫폼별 버튼
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';          // Datetime format
import 'package:itaxi/main.dart';
import 'package:itaxi/themes.dart';       // 이거 임포트 경로가 다를 수 있음. 깃헙이름이 iTaxi 3.0이라서 내 로컬이랑 다를수도..

import 'package:http/http.dart' as http;  // 네트워크 통신 테스트
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'messageModel.dart';

// TODO: 제한된 개수로 채팅 불러오기
// TODO: 이전 기록이 같은 사람이면 텍스트만 보이게하기
// TODO: 이전 기록이 같은 시간이면 아래 시간만 보이게하기

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

// // Class: 채팅 내용
// class ChatMessage extends StatelessWidget {
//   final String content;
//   final String date_time;
//   final String user_name;
//   // final List<String> read;
//   final bool is_chat;
//
//   ChatMessage({this.content, this.date_time, this.user_name, /*this.read,*/ this.is_chat});
//
//   @override
//   Widget build(BuildContext context) {
//     if(is_chat){
//       if(user_name == _name){     // 내가 보낸 메시지
//         return _myChat(context);
//       }
//       else{       // 상대가 보낸 메시지
//         return _othersChat(context);
//       }
//     }
//     else{
//       return _systemChat(context);
//     }
//   }
//
//   // Widget: 내가 보낸 채팅
//   Widget _myChat(BuildContext context){
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   user_name,
//                   style: Theme.of(context).textTheme.headline6,             // subtitle1
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 5.0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(left: 20.0),
//                         child: Text(date_time),
//                       ),
//                       Flexible(
//                         child:  Container(
//                           margin: EdgeInsets.only(left: 10.0),
//                           padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//                           decoration: BoxDecoration(
//                             color: Colors.blueAccent,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(content, style: TextStyle(fontSize: 15, color: Colors.white)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           Container(
//             margin: const EdgeInsets.only(left: 16.0),
//             child: CircleAvatar(child: Text(user_name[0] /*user_name.substring(0, 2)*/)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Widget: 상대가 보낸 채팅
//   Widget _othersChat(BuildContext context){
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(right: 16.0),
//             child: CircleAvatar(child: Text(user_name[0])),
//           ),
//           // 긴 Text 줄 바꿈
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   user_name,
//                   style: Theme.of(context).textTheme.headline6,             // subtitle1
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 5.0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Flexible(
//                         child:  Container(
//                           margin: EdgeInsets.only(right: 10.0),
//                           padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//                           decoration: BoxDecoration(
//                             border: Border.all(width: 0.3),
//                             color: Color.fromRGBO(0xFF, 0xFF, 0xFF, 1),
//                             // color: Color.fromRGBO(0x3F, 0xA9, 0xF5, 0.5),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//
//                           child: Text(content, style: TextStyle(fontSize: 15)),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(right: 20.0),
//                         child: Text(date_time, style: TextStyle(fontSize: 11)
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Widget: 시스템 메시지
//   Widget _systemChat(BuildContext context){
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.black12,
//                   ),
//                   margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 3.0),
//                   padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
//                   child: Text(
//                       content,
//                       style: TextStyle(fontSize: 14,)
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


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


class ChatScreen extends StatefulWidget{
  @override
  State createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  String roomTitle = "채팅방 제목";
  Future<ChatRoomInfo> futureChatRoomInfo;
  Future<void> _launched;

  // 텍스트 컨트롤러 객체
  final _textController = TextEditingController();
  // 채팅기록을 담은 리스트 (messageModel.dart => sampleMessages)
  // final List<ChatMessage> _messages = [];

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

  // 새로고침 컨트롤러 객체
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  int numOfMsg = 0;
  bool isEnablePullUp = true;

  // 정산하기 관련
  TextEditingController dutchPriceController = TextEditingController();
  TextEditingController dutchPeopleController = TextEditingController();
  var _ducthpayFormKey = GlobalKey<FormState>();
  // int numOfPeople = 1;
  String numOfPeople = '1';
  int currPerson = 1;
  int totalPrice = 0;

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed, use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if(mounted){
      if(numOfMsg + 10 < sampleMessages.length){
        numOfMsg += 10;
      }
      else{
        numOfMsg = sampleMessages.length;
        isEnablePullUp = false;
      }
      setState(() {
        // numOfMsg += 10;
      });
    }

    _refreshController.loadComplete();
  }



  // 최초 1번만 데이터 로드할 때,
  @override
  void initState() {
    super.initState();
    futureChatRoomInfo = fetchChatRoomInfo();

    // 보여줄 메시지 개수 세팅
    if(sampleMessages.length <= 10){
      numOfMsg = sampleMessages.length;
    }
    else{
      numOfMsg = 10;
    }

    // TODO: 방 안의 사람숫자 DB에서 불러와서 업데이트
    numOfPeople = '3';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,    // 상태창 글씨 색을 어둡게
        elevation: 0.0,
        // elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        centerTitle: true,
        title: Text(roomTitle, ),
        // leading: IconButton(
        //     icon: Icon(Icons.arrow_back_ios),
        //     color: Colors.white,
        //     onPressed: () {
        //       Navigator.pop(context);
        //     }),
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

    // 이전과 같은 사람?
    String prevUserName = _name;
    String prevDatetime = '0000-00-00 00:00:00';
    // DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

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
            child: SmartRefresher(
              enablePullDown: false,
              enablePullUp: isEnablePullUp,
              header: WaterDropHeader(),
              footer: ClassicFooter(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,

              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(10.0),
                itemCount: numOfMsg,
                reverse: true,
                itemBuilder: (context, int index) {
                  final Message message = sampleMessages[index];
                  final bool isMe = message.user_name == _name;
                  bool isSameUser = false;
                  if(sampleMessages.length - 1> index){
                    isSameUser = sampleMessages[index + 1].user_name == message.user_name;
                  }

                  // ~~ 시 ~~ 분 까지 같은 시간이라면,
                  bool isSameTime = false;
                  if(prevUserName != "시스템"){
                    isSameTime = prevDatetime.substring(0, 16) == message.date_time.substring(0, 16);
                  }
                  bool isSameWithPrevUser = prevUserName == message.user_name;
                  prevUserName = message.user_name;
                  prevDatetime = message.date_time;
                  return _chatBubble(message, isMe, isSameUser, isSameTime, isSameWithPrevUser);
                }
              ),
            ),
          ),

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
                        '더치페이',
                        style: TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () => {
                        createDutchAlertDialog(context).then((onValue){
                          _doDutchPay();
                        })
                      },
                    )
                    : RaisedButton(
                      child: Text('더치페이', style: TextStyle(color: Colors.white)),
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

  _doDutchPay(){
    // 입력된 금액으로 정산해서 시스템 메시지로 전송

    // 메시지 리스트에 사용자가 보낸 메시지를 .insert(index, element)
    var nowTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    String account = '기업 01041548299';
    double dutchPrice = totalPrice / currPerson;
    int resultPrcie = dutchPrice.round();

    String text = '$account (으)로 $resultPrcie 원 입금 부탁드립니다.';

    Message inputMessage = Message(
      content: text,
      date_time: nowTime,
      user_name: _name,
      // user_name: '시스템',
      is_chat: false,
    );

    setState(() {
      sampleMessages.insert(0, inputMessage);
    });
  }

  Future<String> createDutchAlertDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('더치페이', style: TextStyle(/*fontSize: 22,*/ color: Colors.blue, fontWeight: FontWeight.w700)),
        content: Form(
          key: _ducthpayFormKey,
          child: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: dutchPriceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    hintText: '결제한 총 금액을 입력하세요',
                    labelText: '결제한 금액',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return '결제된 금액을 입력해주세요';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: dutchPeopleController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  // initialValue: numOfPeople.toString(
                  decoration: InputDecoration(
                    hintText: '합승한 인원 수를 입력하세요',
                    labelText: '합승한 인원',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return '탑승한 인원을 입력해주세요';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),

        actions: [
          MaterialButton(
            elevation: 5.0,
            child: Text('정산하기', style: TextStyle(fontSize: 15, color: Colors.blueAccent)),
            onPressed: () {
              if (_ducthpayFormKey.currentState.validate()){
                setState(() {
                  totalPrice = int.parse(dutchPriceController.text);
                  currPerson = int.parse(dutchPeopleController.text);
                });
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    });
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
          _elem_participantUnit('장주만', 1, _isVisible01, '01041578299'),
          _elem_participantUnit('홍길참', 2, _isVisible02, '01012341234'),
          _elem_participantUnit('김참길', 3, _isVisible03, '01023452345'),
          _elem_participantUnit('고베어', 4, _isVisible04, '01034564567'),
        ],
      ),
    );
  }

  // Element: 참가자 정보 유닛
  // ignore: non_constant_identifier_names
  Container _elem_participantUnit(name, btnNumber, bool isVisible, String _phone){
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
                onPressed: () => setState(() {
                  _launched = _makePhoneCall('tel:$_phone');
                }),
            ),
          ),
          Visibility(
            visible: isVisible,
            child: IconButton(
                icon: Icon(Icons.message, size: 20),
                // TODO: 문자 보내기
              onPressed: () => setState(() {
                _launched = _makePhoneCall('sms:$_phone');
              }),
            ),
          ),
        ],
      ),
    );
  }

  // 전화걸기
  Future<void> _makePhoneCall(String url) async {
    if(await canLaunch(url)){
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  // Widget: 채팅 말풍선
  Widget _chatBubble(Message message, bool isMe, bool isSameUser, bool isSameTime, bool isSameWithPrevUser) {
    if(message.is_chat){    // 사용자 메시지
      if (isMe) {           // 내가 보낸 채팅
        return Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  !isSameTime ?
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    child: Text(
                      message.date_time.substring(11, 16),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  )
                      : Container(child: null),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.80,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      // color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Text(
                      message.content,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
      else {    // 다른 사람이 보낸 메시지
        return Container(
          alignment: Alignment.topLeft,
          // margin: EdgeInsets.symmetric(vertical: 0.0),
          // margin: !isSameUser ? EdgeInsets.symmetric(vertical: 10.0) : EdgeInsets.symmetric(vertical: 0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !isSameUser ?
              Container(
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 15,
                  child: Text(message.user_name[0]),
                  // backgroundImage: AssetImage(message.sender.imageUrl),
                ),
              )
                  : SizedBox(width: 35),
              SizedBox(width: 10),
              // 긴 Text 줄 바꿈
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !isSameUser ?
                    Text(
                      message.user_name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),            // subtitle1
                    )
                        : Container(child:null),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child:  Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.80,
                              ),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Text(
                                message.content,
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          !isSameTime ?
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            child: Text(
                              message.date_time.substring(11, 16),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                              ),
                            ),
                          )
                              : !isSameWithPrevUser ?
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            child: Text(
                              message.date_time.substring(11, 16),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                              ),
                            ),
                          )
                              : Container(child: null,),
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
    }
    else{     // 시스템 메시지
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
                        message.content,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        )
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
    var nowTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    Message inputMessage = Message(
      content: text,
      date_time: nowTime,
      user_name: _name,
      is_chat: true,
    );

    setState(() {
      sampleMessages.insert(0, inputMessage);
      // _messages.insert(0, inputMessage);
    });

    // ChatMessage inputMessage = ChatMessage(
    //   content: text,
    //   date_time: nowTime,
    //   user_name: _name,
    //   is_chat: true,
    // );
    //
    // setState(() {
    //   sampleMessages.insert(0, inputMessage);
    //   // _messages.insert(0, inputMessage);
    // });

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

// class _ChatScreenState extends State<ChatScreen> {
//   String roomTitle = "채팅방 제목";
//   Future<ChatRoomInfo> futureChatRoomInfo;
//   Future<void> _launched;
//
//   // 텍스트 컨트롤러 객체
//   final _textController = TextEditingController();
//   // 채팅기록을 담은 리스트
//   final List<ChatMessage> _messages = [];
//   // 메시지 입력 후 TextField에 다시 포커싱 담당
//   final FocusNode _focusNode = FocusNode();
//   // 사용자가 입력중인가?
//   bool _isWriting = false;
//   // 사용자 정보 확장 변수
//   bool _isVisible01 = true;
//   bool _isVisible02 = true;
//   bool _isVisible03 = true;
//   bool _isVisible04 = true;
//
//
//   // 스크롤 컨트롤러 객체
//   ScrollController _scrollController = new ScrollController();
//
//   // 새로고침 컨트롤러 객체
//   RefreshController _refreshController = RefreshController(initialRefresh: false);
//
//   int numOfMsg = 10;
//   bool isEnablePullUp = true;
//
//   void _onRefresh() async {
//     // monitor network fetch
//     await Future.delayed(Duration(milliseconds: 1000));
//     // if failed, use refreshFailed()
//     _refreshController.refreshCompleted();
//   }
//
//   void _onLoading() async{
//     // monitor network fetch
//     await Future.delayed(Duration(milliseconds: 1000));
//
//     // if failed,use loadFailed(),if no data return,use LoadNodata()
//
//     if(mounted){
//       if(numOfMsg + 10 < _messages.length){
//         numOfMsg += 10;
//       }
//       else{
//         numOfMsg = _messages.length;
//         isEnablePullUp = false;
//       }
//       setState(() {
//         // numOfMsg += 10;
//       });
//     }
//
//     _refreshController.loadComplete();
//   }
//
//
//
//   // 최초 1번만 데이터 로드할 때,
//   @override
//   void initState() {
//     super.initState();
//     futureChatRoomInfo = fetchChatRoomInfo();
//     // futureAlbum = fetchAlbum();
//
//     // FOR DEBUG
//     var nowTime = DateFormat('HH:mm').format(DateTime.now());
//
//     for(int i=0; i<10; i++) {
//       // 메시지 리스트에 사용자가 보낸 메시지를 .insert(index, element)
//       ChatMessage inputMessage = ChatMessage(
//         content: "샘플메시지입니다." + i.toString(),
//         date_time: nowTime,
//         user_name: "상대방",
//         is_chat: true,
//       );
//
//       setState(() {
//         _messages.insert(0, inputMessage);
//       });
//     }
//
//     // FOR DEBUG
//     for(int i=10; i<20; i++) {
//       // 메시지 리스트에 사용자가 보낸 메시지를 .insert(index, element)
//       ChatMessage inputMessage = ChatMessage(
//         content: "시스템 안내 메시지 입니다." + i.toString(),
//         date_time: nowTime,
//         user_name: "시스템",
//         is_chat: false,
//       );
//
//       setState(() {
//         _messages.insert(0, inputMessage);
//       });
//     }
//
//     // FOR DEBUG
//     for(int i=20; i<30; i++) {
//       // 메시지 리스트에 사용자가 보낸 메시지를 .insert(index, element)
//       ChatMessage inputMessage = ChatMessage(
//         content: "내가보낸 메시지 입니다." + i.toString(),
//         date_time: nowTime,
//         user_name: _name,
//         is_chat: true,
//       );
//
//       setState(() {
//         _messages.insert(0, inputMessage);
//       });
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // resizeToAvoidBottomPadding: false,
//       appBar: AppBar(
//         // TODO: 나중에 setState로 ??? 방장? 이런식으로 제목 바꾸기
//         title: Text(roomTitle),
//         elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
//       ),
//       body: Center(
//         child: FutureBuilder<ChatRoomInfo>(
//           future: futureChatRoomInfo,
//           builder: (context, snapshot) {
//             if(snapshot.hasError){
//               return Text('${snapshot.error}');
//             }
//             return snapshot.hasData ? _wid_chatScreen(snapshot) : CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
//
//   // Widget: 채팅방 스크린
//   // ignore: non_constant_identifier_names
//   Widget _wid_chatScreen([AsyncSnapshot<ChatRoomInfo> snapshot]) {
//     // snapshot 데이터 파싱 (TODO: 나중에 수정)
//     int id = snapshot.data.id;
//     int userId = snapshot.data.userId;
//     String title = snapshot.data.title;
//
//     return Container(
//         child: Column(
//           children: [
//             // 채팅방 정보
//             Container(
//               child: _wid_roomInfo(
//                   departure_place: title,
//                   arrival_place: title,
//                   departure_date: id.toString(),
//                   depature_time: userId.toString()
//               ),
//             ),
//
//             // 채팅기록
//             Flexible(
//               child: SmartRefresher(
//                 enablePullDown: false,
//                 enablePullUp: isEnablePullUp,
//                 header: WaterDropHeader(),
//                 footer: ClassicFooter(),
//                 // CustomFooter(
//                 //   builder: (BuildContext context, LoadStatus mode){
//                 //     Widget body;
//                 //     if(mode==LoadStatus.idle){
//                 //       body =  Text("불러오기에 실패하였습니다. 다시 시도해주세요.");
//                 //     }
//                 //     else if(mode==LoadStatus.loading){
//                 //       body =  CupertinoActivityIndicator();
//                 //     }
//                 //     else if(mode == LoadStatus.failed){
//                 //       body = Text("불러오기에 실패하였습니다. 다시 시도해주세요.");
//                 //     }
//                 //     else if(mode == LoadStatus.canLoading){
//                 //       body = Text("위로 스크롤하여 이전 대화를 확인하세요.");
//                 //     }
//                 //     else{
//                 //       body = Text("이전 데이터가 없습니다.");
//                 //     }
//                 //     return Container(
//                 //       height: 1.0,
//                 //       child: Center(child:body),
//                 //     );
//                 //   },
//                 // ),
//                 controller: _refreshController,
//                 onRefresh: _onRefresh,
//                 onLoading: _onLoading,
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   padding: EdgeInsets.all(8.0),
//                   reverse: true,
//                   itemBuilder: (context, int index) => _messages[index],
//                   itemCount: numOfMsg,
//                   // itemCount: _messages.length,
//                 ),
//               ),
//             ),
//
//
//             // 채팅기록 (원본)
//             // Flexible(
//             //   child: ListView.builder(
//             //     controller: _scrollController,
//             //     padding: EdgeInsets.all(8.0),
//             //     reverse: true,
//             //     itemBuilder: (context, int index) => _messages[index],
//             //     itemCount: _messages.length,
//             //   ),
//             //   // ChatList(),
//             // ),
//
//             // 디바이더
//             Divider(height: 1.0),
//
//             // 채팅 입력창
//             Container(
//               decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor),
//               child: _wid_textInput(),
//             ),
//           ],
//         ),
//         decoration: Theme.of(context).platform == TargetPlatform.iOS
//             ? BoxDecoration(
//           border: Border(
//             top: BorderSide(color: Colors.grey[200]),
//           ),
//         )
//             : null
//     );
//   }
//
//
//   // Widget: 채팅방 정보
//   // ignore: non_constant_identifier_names
//   Widget _wid_roomInfo({String departure_place, String arrival_place, String departure_date, String depature_time}){
//     // 기본값 설정
//     departure_place ??= "";
//     arrival_place ??= "";
//     departure_date ??= "";
//     depature_time ??= "";
//
//     return Container(
//       child: Column(
//         children: [
//           _cmp_roomInfo(
//               departure_place: departure_place,
//               arrival_place: arrival_place,
//               departure_date: departure_date,
//               depature_time: depature_time
//           ),
//           _cmp_participantInfo(),
//         ],
//       ),
//     );
//   }
//
//   // Component: 방정보
//   // ignore: non_constant_identifier_names
//   Container _cmp_roomInfo({String departure_place, String arrival_place, String departure_date, String depature_time}){
//     return Container(
//         padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 7.0),
//
//         decoration: BoxDecoration(
//           border: Border(
//             // bottom: BorderSide(width: 1.0, color: Colors.black26),
//           ),
//           color: Color.fromRGBO(0xF5, 0xF5, 0xF5, 1),
//         ),
//
//         child: Row(
//           children: [
//             Flexible(
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(2.0),
//                     margin: EdgeInsets.all(2.0),
//                     child: Row(
//                       children: [
//                         Text(departure_place, style: TextStyle(fontSize: 20)),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(2.0),
//                     margin: EdgeInsets.all(2.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Icon(Icons.arrow_forward),
//                         Text(" "+arrival_place, style: TextStyle(fontSize: 20)),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(2.0),
//                     margin: EdgeInsets.all(2.0),
//                     child: Row(
//                       children: [
//                         Icon(Icons.departure_board, size: 20),
//                         Text(" "+departure_date+"  "+depature_time, style: TextStyle(fontSize: 20)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 10.0),
//               child: Column(
//                 children: [
//                   Theme.of(context).platform == TargetPlatform.iOS
//                       ? CupertinoButton(
//                     child: Text(
//                       '방 나가기',
//                       style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
//                     ),
//                     onPressed: () => {},
//                   )
//                       : RaisedButton(
//                     child: Text('방 나가기', style: TextStyle(color: Colors.white)),
//                     color: Colors.redAccent,
//                     onPressed: () => {},
//                   ),
//                   // TODO: 방장한테만 보이기, (상관없나?)
//                   Theme.of(context).platform == TargetPlatform.iOS
//                       ? CupertinoButton(
//                     child: Text(
//                       '정산하기',
//                       style: TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.w600),
//                     ),
//                     onPressed: () => {},
//                   )
//                       : RaisedButton(
//                     child: Text('정산하기', style: TextStyle(color: Colors.white)),
//                     color: Colors.indigoAccent,
//                     onPressed: () => {},
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         )
//     );
//   }
//
//
//   // Component: 참가자 리스트
//   // ignore: non_constant_identifier_names
//   Container _cmp_participantInfo(){
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 2.0),
//       decoration: BoxDecoration(
//         border: Border(
//           // bottom: BorderSide(width: 1.0, color: Colors.black26),
//         ),
//         color: Colors.black12,
//       ),
//       // 컨테이너의 높이를 설정
//       height: 55.0,
//       // 리스트뷰 추가
//       child: ListView(
//         // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
//         scrollDirection: Axis.horizontal,
//         // 컨테이너들을 ListView의 자식들로 추가
//         children: [
//           // TODO: 반복문... 안써도 되나?
//           _elem_participantUnit('장주만', 1, _isVisible01, '01041578299'),
//           _elem_participantUnit('홍길참', 2, _isVisible02, '01012341234'),
//           _elem_participantUnit('김참길', 3, _isVisible03, '01023452345'),
//           _elem_participantUnit('고베어', 4, _isVisible04, '01034564567'),
//         ],
//       ),
//     );
//   }
//
//   // Element: 참가자 정보 유닛
//   // ignore: non_constant_identifier_names
//   Container _elem_participantUnit(name, btnNumber, bool isVisible, String _phone){
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
//       padding: EdgeInsets.symmetric(horizontal: 4.0),
//       decoration: BoxDecoration(
//         border: Border.all(width: 1.0, color: Colors.cyan),
//         borderRadius: BorderRadius.circular(30.0),
//         color: Color.fromRGBO(0xF5, 0xF5, 0xF5, 1),
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             iconSize: 60,
//             icon: Container(
//               padding: EdgeInsets.all(5.0),
//               decoration: BoxDecoration(
//                 // border: Border.all(width: 1.0),
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               child: Text(name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//             ),
//             onPressed: () {
//               setState(() {
//                 if(btnNumber == 1){
//                   _isVisible01 = !_isVisible01;
//                 }
//                 else if(btnNumber == 2){
//                   _isVisible02 = !_isVisible02;
//                 }
//                 else if(btnNumber == 3){
//                   _isVisible03 = !_isVisible03;
//                 }
//                 else if(btnNumber == 4){
//                   _isVisible04 = !_isVisible04;
//                 }
//               });
//             },
//           ),
//           Visibility(
//             visible: isVisible,
//             child: IconButton(
//               icon: Icon(Icons.call, size: 20),
//               // TODO: 전화연결
//               onPressed: () => setState(() {
//                 _launched = _makePhoneCall('tel:$_phone');
//               }),
//             ),
//           ),
//           Visibility(
//             visible: isVisible,
//             child: IconButton(
//               icon: Icon(Icons.message, size: 20),
//               // TODO: 문자 보내기
//               onPressed: () => setState(() {
//                 _launched = _makePhoneCall('sms:$_phone');
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _makePhoneCall(String url) async {
//     if(await canLaunch(url)){
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//
//
//
//
//   // Widget: 텍스트 입력
//   // ignore: non_constant_identifier_names
//   Widget _wid_textInput(){
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         children: [
//           Flexible(
//             child: TextField(
//               controller: _textController,
//               onChanged: (String text){
//                 setState(() {
//                   _isWriting = text.length > 0;
//                 });
//               },
//               onSubmitted: _isWriting ? _handleSubmitted : null,
//               decoration: InputDecoration.collapsed(hintText: "보낼 메시지를 입력하세요"),
//               focusNode: _focusNode,
//             ),
//           ),
//           Container(
//               margin: EdgeInsets.symmetric(horizontal: 4.0),
//               child: Theme.of(context).platform == TargetPlatform.iOS
//                   ? CupertinoButton(
//                   child: Text('보내기'),
//                   onPressed: _isWriting ? () => _handleSubmitted(_textController.text) : null)
//                   : IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _isWriting ? () => _handleSubmitted(_textController.text) : null)
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   // Method: 채팅 보내기 클릭시 실행
//   void _handleSubmitted(String text){
//     // 텍스트 필드 비우기
//     _textController.clear();
//
//     // 텍스트 작성중 --> false
//     setState(() {
//       _isWriting = false;
//     });
//
//     // 메시지 리스트에 사용자가 보낸 메시지를 .insert(index, element)
//     var nowTime = DateFormat('HH:mm').format(DateTime.now());
//
//     ChatMessage inputMessage = ChatMessage(
//       content: text,
//       date_time: nowTime,
//       user_name: _name,
//       is_chat: true,
//     );
//
//     setState(() {
//       _messages.insert(0, inputMessage);
//     });
//
//     // TextField에 다시 입력 포커스
//     _focusNode.requestFocus();
//
//     // 맨 아래로 스크롤
//     _scrollController.animateTo(
//       0.0,
//       curve: Curves.easeOut,
//       duration: const Duration(milliseconds: 300),
//     );
//
//   }
// }