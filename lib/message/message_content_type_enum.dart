import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true, valueField: 'type')
enum MessageContentType {
  text(type: 1),
  image(type: 2),
  video(type: 3),
  audio(type: 4),
  file(type: 5),
  location(type: 6),
  custom(type: 7),
  localImage(type: 8),
  localVideo(type: 9);

  final int type;
  const MessageContentType({required this.type});
}
