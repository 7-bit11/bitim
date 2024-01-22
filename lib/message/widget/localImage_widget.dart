// ignore_for_file: file_names

import 'dart:io';

import 'package:bit_im/message/widget/localImage_detail_page.dart';
import 'package:bit_im/message/widget/widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LocalImageMessageWidget extends BaseMessageWidget {
  const LocalImageMessageWidget(
      {super.key, required this.aspectRatio, required this.url});
  final double aspectRatio;
  final String url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return LocalImageDetailPage(url);
              });
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * .3,
              maxWidth: MediaQuery.of(context).size.width * .7,
              minHeight: MediaQuery.of(context).size.height * .1,
              maxHeight: MediaQuery.of(context).size.height * .4),
          child: AspectRatio(
              aspectRatio: aspectRatio,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: ExtendedImage.file(
                    File(url),
                    fit: BoxFit.cover,
                    loadStateChanged: (state) {
                      if (state.extendedImageLoadState == LoadState.loading) {
                        return SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .1,
                          child: Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 245, 245, 245),
                            highlightColor: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        );
                      } else if (state.extendedImageLoadState ==
                          LoadState.failed) {
                        return SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .1,
                          child: Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 245, 245, 245),
                            highlightColor: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ))),
        ));
  }
}