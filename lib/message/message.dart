import 'package:bit_im/message/message_audio.dart';
import 'package:bit_im/message/message_content_type_enum.dart';

class Message {
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
  late ImageInfo? imageInfo;
  //语音信息
  late MessageAudio? messageAudio;
  //构造函数
  Message(
      {required this.message,
      required this.senderId,
      required this.receiverId,
      required this.time,
      required this.contentType,
      this.imageInfo,
      this.messageAudio});
}

//图片信息
class ImageInfo {
  late double width;
  late double height;
  late String url;
  ImageInfo(
      {this.url =
          'https://i2.hdslb.com/bfs/face/d8dc23f1b984dc3c616b5a788ce87d1cf9264231.jpg',
      this.width = 1920,
      this.height = 1080});
}
