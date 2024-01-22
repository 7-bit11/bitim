// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;

class ImageDetailPage extends StatefulWidget {
  const ImageDetailPage(this.url, {super.key});
  final String url;
  @override
  State<ImageDetailPage> createState() => _NewDetailPageState();
}

class _NewDetailPageState extends State<ImageDetailPage>
    with AutomaticKeepAliveClientMixin {
  ///保存图片到本地
  void saveImage() async {
    EasyLoading.show(
        status: "保存中",
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black);
    var response = await http.get(Uri.parse(widget.url));
    if (response.statusCode == 200) {
      await ImageGallerySaver.saveImage(Uint8List.fromList(response.bodyBytes));
      EasyLoading.showSuccess("保存成功", duration: const Duration(seconds: 1));
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
        onTap: () => Get.back(),
        onLongPress: () {
          BitShowModalBottomSheet(context,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Row(children: [
                    GestureDetector(
                      onTap: saveImage,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                color: const Color(0xffF5F5F5),
                                borderRadius: BorderRadius.circular(50)),
                            child: SvgPicture.asset(
                              'assets/images/Download.svg',
                              width: 26,
                              height: 26,
                              colorFilter: const ColorFilter.mode(
                                  Colors.black, BlendMode.srcIn),
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text('保存到手机',
                              style: TextStyle(
                                  color: Colors.grey.shade400, fontSize: 12))
                        ],
                      ),
                    )
                  ]),
                  const SizedBox(height: 20),
                ],
              ));
        },
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(widget.url),
          minScale: .15,
          maxScale: 1.0,
          initialScale: .2,
          enableRotation: true,
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

Future BitShowModalBottomSheet(BuildContext context,
    {Widget? child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(0.0),
    BorderRadiusGeometry? borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(16), topRight: Radius.circular(16))}) async {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      barrierColor: const Color.fromARGB(60, 127, 127, 127),
      builder: (BuildContext context) {
        return Padding(
          padding: padding,
          child: Container(
            // height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: borderRadius,
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: child,
          ),
        );
      });
}
