import 'package:json_annotation/json_annotation.dart';

part 'message_audio.g.dart';

@JsonSerializable()
class MessageAudio {
  late String audioFilePath;
  late String audioFileName;
  //late File waveFile;
  MessageAudio({required this.audioFilePath, required this.audioFileName});

  factory MessageAudio.fromJson(Map<String, dynamic> data) =>
      _$MessageAudioFromJson(data);

  Map<String, dynamic> toJson() => _$MessageAudioToJson(this);
}
