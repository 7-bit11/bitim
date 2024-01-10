import 'package:bit_im/message/widget/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageMessageWidget extends BaseMessageWidget {
  const ImageMessageWidget(
      {super.key, required this.aspectRatio, required this.url});
  final double aspectRatio;
  final String url;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * .3,
            maxWidth: MediaQuery.of(context).size.width * .7,
            minHeight: MediaQuery.of(context).size.height * .1,
            maxHeight: MediaQuery.of(context).size.height * .4),
        child: AspectRatio(
            aspectRatio: aspectRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
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
                  }),
            )));
  }
}
