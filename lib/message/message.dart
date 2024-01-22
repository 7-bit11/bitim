import 'package:bit_im/message/message_audio.dart';
import 'package:bit_im/message/message_content_type_enum.dart';
import 'package:bit_im/message/message_image.dart';
import 'package:bit_im/message/message_video.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class Message {
  //消息ID
  late String messageId;
  //发送信息
  late dynamic message;
  //发送者ID
  late String senderId;
  //接收者ID
  late String receiverId;
  //发送时间
  late String time;
  //消息类型
  late MessageContentType contentType;
  //图片信息
  late String? imageInfoId;
  late ImageInfo? imageInfo;
  //语音信息
  late String? messageAudioId;
  late MessageAudio? messageAudio;
  //视频信息
  late String? messageVideoId;
  late MessageVideo? messageVideo;

  //构造函数
  Message(
      {required this.messageId,
      required this.message,
      required this.senderId,
      required this.receiverId,
      required this.time,
      required this.contentType,
      this.imageInfo,
      this.messageAudio,
      this.messageVideo,
      this.imageInfoId,
      this.messageAudioId,
      this.messageVideoId});

  factory Message.fromJson(Map<String, dynamic> data) =>
      _$MessageFromJson(data);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
