/*
* 메시지 샘플
*/

class Message {
  final String user_name;
  final String content;
  final String date_time;
  final bool is_chat;
  // final int unread;

  Message({this.user_name, this.content, this.date_time, this.is_chat});
}









// EXAMPLE CHATS ON CHAT Screen : 역방향
List<Message> sampleMessages = [
  Message(
    user_name: '시스템',
    content: '최진아 님이 채팅방에 나가셨습니다.',
    date_time: '2020-01-01 12:14:04',
    is_chat: false,
  ),
  Message(
    user_name: '최진아',
    content: '전 이만 나가보겠습니다.',
    date_time: '2020-01-01 12:14:02',
    is_chat: true,
  ),

  Message(
    user_name: '최진아',
    content: '안녕히 계시고.',
    date_time: '2020-01-01 12:13:42',
    is_chat: true,
  ),

  Message(
    user_name: '최진아',
    content: '난 디자인 감각이 참 없습니다;;ㅎ',
    date_time: '2020-01-01 12:13:23',
    is_chat: true,
  ),

  Message(
    user_name: '최진아',
    content: '채팅방이 생각보다 어렵네요.',
    date_time: '2020-01-01 12:13:20',
    is_chat: true,
  ),

  Message(
    user_name: '시스템',
    content: '최진아 님이 채팅방에 참가하였습니다.',
    date_time: '2020-01-01 12:12:01',
    is_chat: false,
  ),

  Message(
    user_name: '송민석',
    content: '디버깅이 잘 되었으면 좋겠네요.',
    date_time: '2020-01-01 12:10:40',
    is_chat: true,
  ),

  Message(
    user_name: '최진아',
    content: '감사합니다.',
    date_time: '2020-01-01 12:09:40',
    is_chat: true,
  ),

  Message(
    user_name: '송민석',
    content: '테스트 데이터를 조금 만들고 있습니다.',
    date_time: '2020-01-01 12:09:30',
    is_chat: true,
  ),

  Message(
    user_name: '송민석',
    content: '안녕하세요 송민석입니다.',
    date_time: '2020-01-01 12:09:20',
    is_chat: true,
  ),

  Message(
    user_name: '시스템',
    content: '송민석 님이 채팅방에 참가하였습니다.',
    date_time: '2020-01-01 12:08:10',
    is_chat: false,
  ),

  Message(
    user_name: '장주만',
    content: '아이택시 채팅방 테스트 데이터를 수기로 작성하는 중입니다.',
    date_time: '2020-01-01 12:03:30',
    is_chat: true,
  ),

  Message(
    user_name: '장주만',
    content: '반갑습니다.',
    date_time: '2020-01-01 12:03:20',
    is_chat: true,
  ),

  Message(
    user_name: '장주만',
    content: '안녕하세요 장주만입니다.',
    date_time: '2020-01-01 12:02:20',
    is_chat: true,
  ),

  Message(
    user_name: '시스템',
    content: '장주만 님이 채팅방을 개설하였습니다.',
    date_time: '2020-01-01 12:02:10',
    is_chat: false,
  ),

];



// EXAMPLE CHATS ON CHAT Screen : 순방향
List<Message> sampleMessages2 = [
  Message(
    user_name: '시스템',
    content: '장주만 님이 채팅방을 개설하였습니다.',
    date_time: '2020-01-01 12:02:10',
    is_chat: false,
  ),

  Message(
    user_name: '장주만',
    content: '안녕하세요 장주만입니다.',
    date_time: '2020-01-01 12:02:20',
    is_chat: true,
  ),

  Message(
    user_name: '장주만',
    content: '반갑습니다.',
    date_time: '2020-01-01 12:03:20',
    is_chat: true,
  ),


  Message(
    user_name: '장주만',
    content: '아이택시 채팅방 테스트 데이터를 수기로 작성하는 중입니다.',
    date_time: '2020-01-01 12:03:30',
    is_chat: true,
  ),


  Message(
    user_name: '시스템',
    content: '송민석 님이 채팅방에 참가하였습니다.',
    date_time: '2020-01-01 12:08:10',
    is_chat: false,
  ),


  Message(
    user_name: '송민석',
    content: '안녕하세요 송민석입니다.',
    date_time: '2020-01-01 12:09:20',
    is_chat: true,
  ),


  Message(
    user_name: '송민석',
    content: '테스트 데이터를 조금 만들고 있습니다.',
    date_time: '2020-01-01 12:09:30',
    is_chat: true,
  ),


  Message(
    user_name: '송민석',
    content: '디버깅이 잘 되었으면 좋겠네요.',
    date_time: '2020-01-01 12:10:40',
    is_chat: true,
  ),


  Message(
    user_name: '시스템',
    content: '최진아 님이 채팅방에 참가하였습니다.',
    date_time: '2020-01-01 12:12:01',
    is_chat: false,
  ),


  Message(
    user_name: '최진아',
    content: '채팅방이 생각보다 어렵네요.',
    date_time: '2020-01-01 12:13:20',
    is_chat: true,
  ),


  Message(
    user_name: '최진아',
    content: '난 디자인 감각이 참 없습니다;;ㅎ',
    date_time: '2020-01-01 12:13:23',
    is_chat: true,
  ),


  Message(
    user_name: '최진아',
    content: '안녕히 계시고.',
    date_time: '2020-01-01 12:13:42',
    is_chat: true,
  ),


  Message(
    user_name: '최진아',
    content: '전 이만 나가보겠습니다.',
    date_time: '2020-01-01 12:14:02',
    is_chat: true,
  ),


  Message(
    user_name: '시스템',
    content: '최진아 님이 채팅방에 나가셨습니다.',
    date_time: '2020-01-01 12:14:04',
    is_chat: false,
  ),
];