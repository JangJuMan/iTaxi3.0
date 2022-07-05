// /*
// * 작성자: 장주만, 01041578299, wnaks9901@gmail.com
// *
// * [CLASS]
// *   ChatRoomInfo : 채탕방 정보
// *     List<Participant> : 참여자 정보
// *     List<Chat> : 채팅 정보
// *
// * Future<ChatRoomInfo>
// *   채팅방 데이터 받아오기
// *
// * ChatScreen(Stateful)
// *   => _ChatScreenState(State<ChatScreen>)
// *     build(Scafold)
// *       AppBar
// *       body: Center
// *         FutureBuilder : 데이터 불러오기
// *           ㄴ  _wid_chatScreen : 채팅방 스크린
// *                 _wid_roomInfo : 채팅방 정보
// *                     _comp_roomInfo(방 정보)
// *                     _comp_participantInfo(참여자 정보)
// *
// *           ㄴ   Flexible(채팅기록)
// *                 SmartRefresher
// *                   ListBuilder : 채팅 말풍선(_chatBubble)
// *
// *           ㄴ   _wid_textInput(채팅 입력창)
// *
// * createDutchAlertDialog : 더치페이 Dialog 창
// *
// * [Method]
// * _onRefresh : 새로고침
// * _onLoading : 새로고침 로딩중
// * _doDutchPay : 더치페이
// * _handleSubmitted : 새로운 메시지 보내기
// *
// *
// *
// * */
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart'; // 테마
// import 'package:flutter/cupertino.dart';  // 플랫폼별 버튼
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';          // Datetime format
// import 'messageModel.dart';
//
// import 'package:http/http.dart' as http;  // 네트워크 통신 테스트
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// // Widget > Component > Element
//
// // TODO: 로그인한 사용자의 이름으로 일괄 수정 필요
// String _name = "장주만";
//
// // 참여자 정보
// class Participant{
//   String user_name;
//   String phone_number;
//   String user_id;
//
//   Participant(this.user_name, this.phone_number, this.user_id);
//
//   factory Participant.fromJson(dynamic json){
//     return Participant(
//       json['user_name'] as String,
//       json['phone_number'] as String,
//       json['user_id'] as String,
//     );
//   }
// }
//
// // 채팅 정보
// class Chat{
//   String content;
//   String date_time;
//   String user_name;
//   bool is_chat;
//   List reads;
//
//   // 리스트는 [] 를 씌워주는가바.
//   Chat(this.content, this.date_time, this.user_name, this.is_chat, [this.reads]);
//
//   factory Chat.fromJson(dynamic json){
//     // 단순(String) 리스트로 파싱하기
//     var readsJson = json['read'] as List;
//     List _read = readsJson != null ? List.from(readsJson) : null;
//
//     return Chat(
//       json['content'] as String,
//       json['date_time'] as String,
//       json['user_name'] as String,
//       json['is_chat'] as bool,
//       _read
//     );
//   }
// }
//
// // Class: 채팅방 정보
// class ChatRoomInfo {
//   String _id;
//   String departure_date;
//   String departure_time;
//   String departure_place;
//   String arrival_place;
//   List participants;
//   int max_people;
//   int curr_people;
//   List chats;
//   bool is_paid;
//
//
//   // 리스트는 []를 씌워 주는가바
//   ChatRoomInfo(
//     this._id, this.departure_date, this.departure_time,
//     this.departure_place, this.arrival_place, this.max_people,
//     this.curr_people, this.is_paid, [this.participants, this.chats]
//   );
//
//
//   factory ChatRoomInfo.fromJson(json){
//     // 참여자 정보 (Object List 로 파싱)
//     var participantJson = json['participants'] as List;
//     List _participants = participantJson.map((partiJson) => Participant.fromJson(partiJson)).toList();
//
//     // 채팅정보 (Object List 로 파싱)
//     var chatsJson = json['chats'] as List;
//     List _chats = chatsJson.map((chatJson) => Chat.fromJson(chatJson)).toList();
//
//     // 순서 잘 지키기
//     return ChatRoomInfo(
//       json['_id'] as String,
//       json['departure_date'] as String,
//       json['departure_time'] as String,
//       json['departure_place'] as String,
//       json['arrival_place'] as String,
//       json['max_people'] as int,
//       json['curr_people'] as int,
//       json['is_paid'] as bool,
//       _participants,
//       _chats,
//     );
//   }
// }
//
//
// // Method: 채팅방 정보 받아오기.
// Future<ChatRoomInfo> fetchChatRoomInfo() async {
//   // final response = await http.get('https://jsonplaceholder.typicode.com/albums');
//   final response = await http.get('http://3.16.102.171:9876/taxi/6027b4a063c216d683d7edd1');
//
//   if(response.statusCode == 200){
//     return ChatRoomInfo.fromJson(jsonDecode(response.body));
//   }
//   else{
//     throw Exception('Failed to load ChatRoomInfo');
//   }
// }
//
//
// class ChatScreen extends StatefulWidget{
//   @override
//   State createState() => _ChatScreenState();
// }
//
//
// class _ChatScreenState extends State<ChatScreen> {
//   // TODO: 채팅방 제목 DB에서 받아온 정보로 (???방장 or 좋을대로)
//   String roomTitle = "채팅방 제목";
//   Future<ChatRoomInfo> futureChatRoomInfo;
//   Future<void> _launched;
//
//   // TODO: 샘플 채팅 데이터를 실제 데이터로 바꾸기. (샘플데이터는 messageModel.dart에 있음)
//
//   // 텍스트 컨트롤러 객체
//   final _textController = TextEditingController();
//
//   // 메시지 입력 후 TextField에 다시 포커싱 담당
//   final FocusNode _focusNode = FocusNode();
//
//   // 사용자가 입력중인가?
//   bool _isWriting = false;
//
//   // 상단 사용자 아이콘의 확장 여부 변수 (택시기준으로 4개 만들었다가 카풀은? 해서 6개까지 만듦)
//   // TODO: 가장 좋은건 데이터 통신으로 max_people 사이즈대로 만들어 놓는 것.
//   List isParticipantVisible = [true, true, true, true, true, true];
//
//   // 스크롤 컨트롤러 객체
//   ScrollController _scrollController = new ScrollController();
//
//   // 새로고침 컨트롤러 객체
//   RefreshController _refreshController = RefreshController(initialRefresh: false);
//   bool isEnablePullUp = true;
//
//   // 채팅의 개수 저장. 초기값 선언. 데이터 로드되면 새로운 값으로 재할당
//   int numOfMsg = 0;
//
//   // 정산하기 관련
//   TextEditingController dutchPriceController = TextEditingController();
//   TextEditingController dutchPeopleController = TextEditingController();
//   var _ducthpayFormKey = GlobalKey<FormState>();
//   // 출력할때 String이 편하더라구요 그래서 int 아니고 String 했음.
//   String numOfPeople = '1';
//   int currPerson = 1;
//   int totalPrice = 0;
//
//   // 새로고침
//   void _onRefresh() async {
//     // monitor network fetch
//     await Future.delayed(Duration(milliseconds: 1000));
//     // if failed, use refreshFailed()
//     _refreshController.refreshCompleted();
//   }
//
//   // 새로고침 되는 로딩시간
//   void _onLoading() async{
//     // monitor network fetch
//     await Future.delayed(Duration(milliseconds: 1000));
//
//     // if failed,use loadFailed(),if no data return,use LoadNodata()
//
//     if(mounted){
//       // TODO: sampleMessage 에서 실제 채팅 데이터로 바꿔야 함.
//       // 새로고침 할때마다 10개씩 더보여줌. 조정 가능
//       if(numOfMsg + 10 < sampleMessages.length){
//         numOfMsg += 10;
//       }
//       else{
//         numOfMsg = sampleMessages.length;
//         // 메시지를 끝까지 다 올리면 새로고침이 더 안되도록 함.
//         isEnablePullUp = false;
//       }
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
//
//     // 보여줄 메시지 개수 세팅
//     // TODO: sampleMessage -> 실제 채팅 데이터로 바꿔야 함.
//     // TODO: 보여주는 메시지 개수 조정필요. (한.. 20? 30? 이 적당하지 않을까? 지금은 보여주기 위해서 10개로 해놓음.)
//     if(sampleMessages.length <= 10){
//       // 10개보다 안되면 딱 고만큼만..!
//       numOfMsg = sampleMessages.length;
//     }
//     else{
//       numOfMsg = 10;
//     }
//
//     // TODO: 방 안의 사람숫자 max_people DB에서 불러와서 업데이트
//     // 데이터는 불러왔는데 어떻게 부르는지를 모르네 하하핳ㅎ;;;;ㅈㅅ
//     numOfPeople = '3';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         brightness: Brightness.light,    // 상태창 글씨 색을 어둡게
//         elevation: 0.0,
//         // elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
//         centerTitle: true,
//         title: Text(roomTitle, style: TextStyle(fontSize: 18)),
//         // 하얀 바탕의 검은 화살표. 위의 세팅으로 다 표시가 되는데 혹시 안되면 이 부분 쓸 것.
//         // leading: IconButton(
//         //   icon: Icon(Icons.arrow_back_ios),
//         //   color: Colors.black,
//         //   onPressed: () {
//         //     Navigator.pop(context);
//         //   }
//         // ),
//       ),
//       body: Center(
//         // 데이터 받아와서 랜더링
//         child: FutureBuilder<ChatRoomInfo>(
//           future: futureChatRoomInfo,
//           builder: (context, snapshot) {
//             if(snapshot.hasError){
//               return Text('${snapshot.error}');
//             }
//             // 데이터가 있을때까지 progressIndicator 돌리고, 데이터 오면 렌더링 시작
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
//     // 이전과 같은 사람의 말풍선인지 확인하기 위해
//     String prevUserName = _name;
//     String prevDatetime = '0000-00-00 00:00:00';
//
//     return Container(
//       child: Column(
//         children: [
//           // 채팅방 정보
//           Container(
//             child: _wid_roomInfo(
//               departure_place: snapshot.data.departure_place,
//               arrival_place: snapshot.data.arrival_place,
//               departure_date: snapshot.data.departure_date,
//               departure_time: snapshot.data.departure_time,
//               max_people: snapshot.data.max_people,
//               curr_people: snapshot.data.curr_people,
//               participants: snapshot.data.participants,
//             ),
//           ),
//
//           // 채팅기록
//           Flexible(
//             // 새로고침 위젯
//             child: SmartRefresher(
//               enablePullDown: false,
//               enablePullUp: isEnablePullUp,
//               header: WaterDropHeader(),
//               footer: ClassicFooter(),
//               controller: _refreshController,
//               onRefresh: _onRefresh,
//               onLoading: _onLoading,
//
//               // 채팅 말풍선 빌더
//               child: ListView.builder(
//                 controller: _scrollController,
//                 padding: EdgeInsets.all(10.0),
//                 itemCount: numOfMsg,
//                 reverse: true,
//                 itemBuilder: (context, int index) {
//                   final Message message = sampleMessages[index];
//                   final bool isMe = message.user_name == _name;
//                   bool isSameUser = false;
//                   if(sampleMessages.length - 1> index){
//                     isSameUser = sampleMessages[index + 1].user_name == message.user_name;
//                   }
//
//                   // ~~ 시 ~~ 분 까지 같은 시간이라면,
//                   bool isSameTime = false;
//                   if(prevUserName != "시스템"){
//                     isSameTime = prevDatetime.substring(0, 16) == message.date_time.substring(0, 16);
//                   }
//                   bool isSameWithPrevUser = prevUserName == message.user_name;
//                   prevUserName = message.user_name;
//                   prevDatetime = message.date_time;
//                   return _chatBubble(message, isMe, isSameUser, isSameTime, isSameWithPrevUser);
//                 }
//               ),
//             ),
//           ),
//
//           // 채팅 입력창
//           Container(
//             decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor),
//             child: _wid_textInput(),
//           ),
//         ],
//       ),
//       decoration: Theme.of(context).platform == TargetPlatform.iOS
//           ? BoxDecoration(
//             border: Border(
//               top: BorderSide(color: Colors.grey[200]),
//             ),
//           )
//           : null
//     );
//   }
//
//
//   // Widget: 채팅방 정보
//   // ignore: non_constant_identifier_names
//   Widget _wid_roomInfo({String departure_place, String arrival_place, String departure_date, String departure_time, int max_people, int curr_people, List participants}){
//     // 기본값 설정
//     departure_place ??= "";
//     arrival_place ??= "";
//     departure_date ??= "";
//     departure_time ??= "";
//     max_people ??= 4;
//     curr_people ??= 1;
//     participants ??= [];
//
//     return Container(
//       child: Column(
//         children: [
//           _cmp_roomInfo(
//             departure_place: departure_place,
//             arrival_place: arrival_place,
//             departure_date: departure_date,
//             departure_time: departure_time,
//             max_people: max_people,
//             curr_people: curr_people,
//           ),
//           _cmp_participantInfo(
//             participants: participants,
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Component: 방정보
//   // ignore: non_constant_identifier_names
//   Container _cmp_roomInfo({String departure_place, String arrival_place, String departure_date, String departure_time, int max_people, int curr_people}){
//     return Container(
//       padding: EdgeInsets.all(1.0),
//
//       child: Row(
//         children: [
//           Flexible(
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
//                   margin: EdgeInsets.all(2.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(departure_place+" ", style: TextStyle(fontSize: 16)),
//                       Icon(Icons.arrow_forward, size: 16,),
//                       Text(" "+arrival_place, style: TextStyle(fontSize: 16)),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
//                   margin: EdgeInsets.all(0.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Icon(Icons.departure_board, size: 16),
//                       Text(departure_date+"  "+departure_time+"    ", style: TextStyle(fontSize: 16)),
//                       Icon(Icons.people, size: 16),
//                       Text('('+curr_people.toString()+' / '+max_people.toString()+')', style: TextStyle(fontSize: 16)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 10.0),
//             child: Column(
//               children: [
//                 CupertinoButton(
//                   child: Text(
//                     '방 나가기',
//                     style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600, fontSize: 16),
//                   ),
//                   onPressed: () => {},
//                 ),
//                 CupertinoButton(
//                     child: Text(
//                       '더치페이',
//                       style: TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.w600, fontSize: 16),
//                     ),
//                     onPressed: () => {
//                       createDutchAlertDialog(context).then((onValue){
//                       // _doDutchPay();
//                       })
//                     },
//                 ),
//
//                 // TODO: 테마별 적용을 하시겠다면 아래의 코드를 사용. 근데 난 쿠퍼티노 버튼이 이쁘더라
//                 /*Theme.of(context).platform != TargetPlatform.iOS
//                     ? CupertinoButton(
//                       child: Text(
//                         '방 나가기',
//                         style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600, fontSize: 16),
//                       ),
//                       onPressed: () => {},
//                     )
//                     : RaisedButton(
//                       child: Text('방 나가기', style: TextStyle(color: Colors.white)),
//                       color: Colors.redAccent,
//                       onPressed: () => {},
//                     ),
//
//                 Theme.of(context).platform != TargetPlatform.iOS
//                     ? CupertinoButton(
//                       child: Text(
//                         '더치페이',
//                         style: TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.w600, fontSize: 16),
//                       ),
//                       onPressed: () => {
//                         createDutchAlertDialog(context).then((onValue){
//                           _doDutchPay();
//                         })
//                       },
//                     )
//                     : RaisedButton(
//                       child: Text('더치페이', style: TextStyle(color: Colors.white)),
//                       color: Colors.indigoAccent,
//                       onPressed: () => {
//                         createDutchAlertDialog(context).then((onValue){
//                           _doDutchPay();
//                         })
//                       },
//                     ),*/
//               ],
//             ),
//           ),
//         ],
//       )
//     );
//   }
//
//   // 더치페이 계산하기
//   // TODO: sampleMessage -> 실제 데이터로 post하도록 수정
//   _doDutchPay(){
//     // 입력된 금액으로 정산해서 시스템 메시지로 전송
//
//     // 메시지 리스트에 사용자가 보낸 메시지를 .insert(index, element)
//     var nowTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
//
//     String account = '기업 01041548299';
//     double dutchPrice = totalPrice / currPerson;
//     int resultPrcie = dutchPrice.round();
//
//     String text = '$account 로 $resultPrcie 원 입금 부탁드립니다.';
//
//     // 새로운 메시지 생성 (TODO: messageModel.dart 에 있음)
//     Message inputMessage = Message(
//       content: text,
//       date_time: nowTime,
//       // TODO: 로그인한 사용자의 이름이 _name 이어야 한다.
//       user_name: _name,
//       // 시스템 메시지로 출력되기 때문에 유저네임은 크게 중요x. 누가 말한지는 기록만 하자.
//       // user_name: '시스템',
//       is_chat: false,
//     );
//
//     // 샘플 데이터에 추가 및 보여주는 메시지 길이 +1
//     setState(() {
//       sampleMessages.insert(0, inputMessage);
//       numOfMsg++;
//       // isEnablePullUp = true;
//     });
//
//     // 맨 아래로 스크롤
//     _scrollController.animateTo(
//       0.0,
//       curve: Curves.easeOut,
//       duration: const Duration(milliseconds: 300),
//     );
//   }
//
//   // 정산하기 Dialog 창 띄우기
//   Future<String> createDutchAlertDialog(BuildContext context){
//     return showDialog(context: context, builder: (context){
//       return AlertDialog(
//         title: Text('더치페이', style: TextStyle(/*fontSize: 22,*/ color: Colors.blue, fontWeight: FontWeight.w700)),
//         content: Form(
//           key: _ducthpayFormKey,
//           child: SizedBox(
//             height: 250,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Text(' 결제된 금액을 탑승한 인원수로 나누고,\n소수 첫째 자리에서 반올림한 값입니다.', style: TextStyle(fontSize: 13, color: Colors.black54),),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   controller: dutchPriceController,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                   ],
//                   decoration: InputDecoration(
//                     hintText: '결제한 총 금액을 입력하세요',
//                     labelText: '결제한 금액',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return '결제된 금액을 입력해주세요';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: dutchPeopleController,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                   ],
//                   // initialValue: numOfPeople.toString(
//                   decoration: InputDecoration(
//                     hintText: '합승한 인원 수를 입력하세요',
//                     labelText: '합승한 인원',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return '탑승한 인원을 입력해주세요';
//                     }
//                     return null;
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         actions: [
//           MaterialButton(
//             elevation: 5.0,
//             child: Text('정산하기', style: TextStyle(fontSize: 15, color: Colors.blueAccent)),
//             onPressed: () {
//               if (_ducthpayFormKey.currentState.validate()){
//                 setState(() {
//                   totalPrice = int.parse(dutchPriceController.text);
//                   currPerson = int.parse(dutchPeopleController.text);
//                 });
//                 Navigator.of(context).pop();
//                 _doDutchPay();
//               }
//             },
//           ),
//         ],
//       );
//     });
//   }
//
//   // Component: 참가자 리스트
//   // ignore: non_constant_identifier_names
//   Container _cmp_participantInfo({List participants}){
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 2.0),
//       decoration: BoxDecoration(
//         color: Colors.black12,
//       ),
//
//       // 컨테이너의 높이를 설정
//       height: 50.0,
//
//       // 리스트뷰 추가
//       child: ListView(
//         // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
//         scrollDirection: Axis.horizontal,
//
//         // 컨테이너들을 ListView의 자식들로 추가
//         children: <Widget>[
//           for(int i = 0; i < participants.length; i++)
//             _elem_participantUnit(participants[i].user_name, i, isParticipantVisible[i], participants[i].phone_number),
//
//           // 샘플: _elem_participantUnit('장주만', 1, true, '01041578299'),
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
//       padding: EdgeInsets.symmetric(horizontal: 3.0),
//       decoration: BoxDecoration(
//         border: Border.all(width: 1.0, color: Colors.cyan),
//         borderRadius: BorderRadius.circular(30.0),
//         color: Color.fromRGBO(0xF5, 0xF5, 0xF5, 1),
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             iconSize: 55,
//             icon: Container(
//               child: Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//             ),
//             // 눌리는 사람꺼 확인해서 hide or show 하기.
//             onPressed: () {
//               setState(() {
//                 if(btnNumber == 0){
//                   isParticipantVisible[0] = !isParticipantVisible[0];
//                 }
//                 else if(btnNumber == 1){
//                   isParticipantVisible[1] = !isParticipantVisible[1];
//                 }
//                 else if(btnNumber == 2){
//                   isParticipantVisible[2] = !isParticipantVisible[2];
//                 }
//                 else if(btnNumber == 3){
//                   isParticipantVisible[3] = !isParticipantVisible[3];
//                 }
//               });
//             },
//           ),
//           // hide 모드일때 안보이도록 하기.
//           Visibility(
//             visible: isVisible,
//             child: IconButton(
//               icon: Icon(Icons.call, size: 16),
//               onPressed: () => setState(() {
//                 _launched = _makePhoneCall('tel:$_phone');
//               }),
//             ),
//           ),
//           Visibility(
//             visible: isVisible,
//             child: IconButton(
//               icon: Icon(Icons.message, size: 16),
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
//   // 전화걸기
//   Future<void> _makePhoneCall(String url) async {
//     if(await canLaunch(url)){
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//
//   // Widget: 채팅 말풍선
//   Widget _chatBubble(Message message, bool isMe, bool isSameUser, bool isSameTime, bool isSameWithPrevUser) {
//     // 사용자 메시지
//     if(message.is_chat){
//       // 내가 보낸 메시지
//       if (isMe) {
//         return Column(
//           children: <Widget>[
//             Container(
//               alignment: Alignment.topRight,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   !isSameTime ?
//                   Container(
//                     margin: EdgeInsets.only(right: 5.0),
//                     child: Text(
//                       message.date_time.substring(11, 16),
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.black45,
//                       ),
//                     ),
//                   )
//                       : Container(child: null),
//                   Container(
//                     constraints: BoxConstraints(
//                       maxWidth: MediaQuery.of(context).size.width * 0.80,
//                     ),
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(vertical: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.blueAccent,
//                       // color: Theme.of(context).primaryColor,
//                       borderRadius: BorderRadius.circular(15),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: Text(
//                       message.content,
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }
//       // 다른 사람이 보낸 메시지
//       else {
//         return Container(
//           alignment: Alignment.topLeft,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               !isSameUser ?
//               Container(
//                 width: 35,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: CircleAvatar(
//                   radius: 15,
//                   child: Text(message.user_name[0]),
//                   // backgroundImage: AssetImage(message.sender.imageUrl),
//                 ),
//               )
//                   : SizedBox(width: 35),
//               SizedBox(width: 10),
//               // 긴 Text 줄 바꿈
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     !isSameUser ?
//                     Text(
//                       message.user_name,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),            // subtitle1
//                     )
//                         : Container(child:null),
//                     Container(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Flexible(
//                             child:  Container(
//                               constraints: BoxConstraints(
//                                 maxWidth: MediaQuery.of(context).size.width * 0.80,
//                               ),
//                               padding: EdgeInsets.all(10),
//                               margin: EdgeInsets.symmetric(vertical: 10),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 2,
//                                     blurRadius: 5,
//                                   ),
//                                 ],
//                               ),
//                               child: Text(
//                                 message.content,
//                                 style: TextStyle(
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           !isSameTime ?
//                           Container(
//                             margin: EdgeInsets.only(left: 5.0),
//                             child: Text(
//                               message.date_time.substring(11, 16),
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.black45,
//                               ),
//                             ),
//                           )
//                               : !isSameWithPrevUser ?
//                           Container(
//                             margin: EdgeInsets.only(left: 5.0),
//                             child: Text(
//                               message.date_time.substring(11, 16),
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.black45,
//                               ),
//                             ),
//                           )
//                               : Container(child: null,),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       }
//     }
//     // 시스템 메시지
//     else{
//       return Container(
//         margin: EdgeInsets.symmetric(vertical: 10.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     constraints: BoxConstraints(
//                       maxWidth: MediaQuery.of(context).size.width * 0.80,
//                     ),
//                     margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
//                     padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white30,
//                       borderRadius: BorderRadius.circular(15),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: GestureDetector(
//                       // 길게 클릭시 (난 이걸 선호함.)
//                       onLongPress: () {
//                         Clipboard.setData(ClipboardData(text: message.content));
//                         Fluttertoast.showToast(msg: "클립보드에 복사되었습니다.");
//                       },
//                       // 짧게라도 클릭시
//                       // onTap: () {
//                       //   Clipboard.setData(ClipboardData(text: message.content));
//                       //   Fluttertoast.showToast(msg: "클립보드에 복사되었습니다.");
//                       // },
//                       child: Text(
//                           message.content,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.black54,
//                           )
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }
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
//             margin: EdgeInsets.symmetric(horizontal: 4.0),
//             child: Theme.of(context).platform == TargetPlatform.iOS
//                 ? CupertinoButton(
//                   child: Text('보내기'),
//                   onPressed: _isWriting ? () => _handleSubmitted(_textController.text) : null)
//                 : IconButton(
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
//   // TODO: sampleMessage -> 실제 데이터에 추가되도록
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
//     var nowTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
//
//     // 새로운 메시지 생성 (TODO: messageModel.dart 에 있음)
//     Message inputMessage = Message(
//       content: text,
//       date_time: nowTime,
//       user_name: _name,
//       is_chat: true,
//     );
//
//     // 메시지 추가 및 보여주는 메시지 +1
//     setState(() {
//       sampleMessages.insert(0, inputMessage);
//       numOfMsg++;
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
//   }
// }