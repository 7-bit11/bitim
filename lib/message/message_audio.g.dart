// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageAudio _$MessageAudioFromJson(Map<String, dynamic> json) => MessageAudio(
      audioFilePath: json['audioFilePath'] as String,
      audioFileName: json['audioFileName'] as String,
    );

Map<String, dynamic> _$MessageAudioToJson(MessageAudio instance) =>
    <String, dynamic>{
      'audioFilePath': instance.audioFilePath,
      'audioFileName': instance.audioFileName,
    };
