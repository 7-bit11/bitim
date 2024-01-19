// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVideo _$MessageVideoFromJson(Map<String, dynamic> json) => MessageVideo(
      url: json['url'] as String,
      height: (json['height'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
    );

Map<String, dynamic> _$MessageVideoToJson(MessageVideo instance) =>
    <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
