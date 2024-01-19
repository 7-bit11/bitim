import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true, valueField: 'id')
enum ChatsStateEnum {
  online(name: 'online', id: 0),
  offline(name: 'offline', id: 1);

  final String name;

  final int id;
  const ChatsStateEnum({required this.name, required this.id});

  static ChatsStateEnum createChatsState(int id) {
    return ChatsStateEnum.values.firstWhere((element) => element.id == id);
  }
}
