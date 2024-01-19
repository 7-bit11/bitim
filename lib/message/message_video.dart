import 'package:json_annotation/json_annotation.dart';
part 'message_video.g.dart';

@JsonSerializable()
class MessageVideo {
  late String url;
  late double width;
  late double height;
  MessageVideo({required this.url, required this.height, required this.width});

  factory MessageVideo.fromJson(Map<String, dynamic> data) =>
      _$MessageVideoFromJson(data);

  Map<String, dynamic> toJson() => _$MessageVideoToJson(this);
}
