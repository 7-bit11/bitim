// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatsModel _$ChatsModelFromJson(Map<String, dynamic> json) => ChatsModel(
      id: json['id'] as int,
      url: json['url'] as String,
      name: json['name'] as String? ?? '',
      time: json['time'] as String? ?? '',
      message: json['message'] as String,
      count: json['count'] as int? ?? 0,
      state: $enumDecodeNullable(_$ChatsStateEnumEnumMap, json['state']) ??
          ChatsStateEnum.offline,
    );

Map<String, dynamic> _$ChatsModelToJson(ChatsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'time': instance.time,
      'message': instance.message,
      'count': instance.count,
      'state': _$ChatsStateEnumEnumMap[instance.state]!,
    };

const _$ChatsStateEnumEnumMap = {
  ChatsStateEnum.online: 0,
  ChatsStateEnum.offline: 1,
};
