import 'package:json_annotation/json_annotation.dart';

part 'message_image.g.dart';

//图片信息
@JsonSerializable()
class ImageInfo {
  late double width;
  late double height;
  late String url;
  ImageInfo(
      {this.url =
          'https://i2.hdslb.com/bfs/face/d8dc23f1b984dc3c616b5a788ce87d1cf9264231.jpg',
      this.width = 1920,
      this.height = 1080});

  factory ImageInfo.fromJson(Map<String, dynamic> data) =>
      _$ImageInfoFromJson(data);

  Map<String, dynamic> toJson() => _$ImageInfoToJson(this);
}
