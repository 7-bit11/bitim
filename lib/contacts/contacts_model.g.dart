// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsModel _$ContactsModelFromJson(Map<String, dynamic> json) =>
    ContactsModel(
      url: json['url'] as String,
      name: json['name'] as String? ?? '',
      time: json['time'] as String? ?? '',
      tagIndex: json['tagIndex'] as String?,
      state: $enumDecodeNullable(_$ChatsStateEnumEnumMap, json['state']) ??
          ChatsStateEnum.offline,
    )..isShowSuspension = json['isShowSuspension'] as bool;

Map<String, dynamic> _$ContactsModelToJson(ContactsModel instance) =>
    <String, dynamic>{
      'isShowSuspension': instance.isShowSuspension,
      'url': instance.url,
      'name': instance.name,
      'time': instance.time,
      'tagIndex': instance.tagIndex,
      'state': _$ChatsStateEnumEnumMap[instance.state]!,
    };

const _$ChatsStateEnumEnumMap = {
  ChatsStateEnum.online: 0,
  ChatsStateEnum.offline: 1,
};
