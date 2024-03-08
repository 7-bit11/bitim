// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      messageId: json['messageId'] as String,
      message: json['message'],
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      time: json['time'] as String,
      contentType:
          $enumDecode(_$MessageContentTypeEnumMap, json['contentType']),
      imageInfo: json['imageInfo'] == null
          ? null
          : ImageInfo.fromJson(json['imageInfo'] as Map<String, dynamic>),
      messageAudio: json['messageAudio'] == null
          ? null
          : MessageAudio.fromJson(json['messageAudio'] as Map<String, dynamic>),
      messageVideo: json['messageVideo'] == null
          ? null
          : MessageVideo.fromJson(json['messageVideo'] as Map<String, dynamic>),
      imageInfoId: json['imageInfoId'] as String?,
      messageAudioId: json['messageAudioId'] as String?,
      messageVideoId: json['messageVideoId'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'messageId': instance.messageId,
      'message': instance.message,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'time': instance.time,
      'contentType': _$MessageContentTypeEnumMap[instance.contentType]!,
      'imageInfoId': instance.imageInfoId,
      'imageInfo': instance.imageInfo,
      'messageAudioId': instance.messageAudioId,
      'messageAudio': instance.messageAudio,
      'messageVideoId': instance.messageVideoId,
      'messageVideo': instance.messageVideo,
    };

const _$MessageContentTypeEnumMap = {
  MessageContentType.text: 1,
  MessageContentType.image: 2,
  MessageContentType.video: 3,
  MessageContentType.audio: 4,
  MessageContentType.file: 5,
  MessageContentType.location: 6,
  MessageContentType.custom: 7,
  MessageContentType.localImage: 8,
  MessageContentType.localVideo: 9,
};
