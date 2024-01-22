// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class LocalImageDetailPage extends StatefulWidget {
  const LocalImageDetailPage(this.url, {super.key});
  final String url;
  @override
  State<LocalImageDetailPage> createState() => _NewDetailPageState();
}

class _NewDetailPageState extends State<LocalImageDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
        onTap: () => Get.back(),
        child: PhotoView(
          enablePanAlways: true,
          imageProvider: FileImage(File(widget.url)),
          minScale: .15,
          maxScale: 1.0,
          initialScale: .2,
          enableRotation: true,
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
