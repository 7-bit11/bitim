// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageInfo _$ImageInfoFromJson(Map<String, dynamic> json) => ImageInfo(
      url: json['url'] as String? ??
          'https://i2.hdslb.com/bfs/face/d8dc23f1b984dc3c616b5a788ce87d1cf9264231.jpg',
      width: (json['width'] as num?)?.toDouble() ?? 1920,
      height: (json['height'] as num?)?.toDouble() ?? 1080,
    );

Map<String, dynamic> _$ImageInfoToJson(ImageInfo instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
    };
