import 'package:bit_im/enum/chats_state_enum.dart';

class ChatsModel {
  late int id;
  late String url;
  late String name;
  late String time;
  late String message;
  late int count;
  late ChatsStateEnum state;
  ChatsModel(
      {required this.id,
      required this.url,
      this.name = '',
      this.time = '',
      required this.message,
      this.count = 0,
      this.state = ChatsStateEnum.offline});
}
