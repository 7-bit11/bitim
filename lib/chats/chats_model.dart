import 'package:bit_im/enum/chats_state_enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chats_model.g.dart';

@JsonSerializable()
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

  factory ChatsModel.fromJson(Map<String, dynamic> data) =>
      _$ChatsModelFromJson(data);

  Map<String, dynamic> toJson() => _$ChatsModelToJson(this);
}
