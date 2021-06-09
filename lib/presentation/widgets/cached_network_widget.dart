import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/presentation/widgets/custom_loading.dart';

class ImageDisplayWidget extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const ImageDisplayWidget({Key key, this.url, this.fit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      placeholder: (context, url) => Container(
        height: 100,
        width: 100,
        child: const Center(
            child: Loading(
          size: 40,
        )),
      ),
      errorWidget: (context, url, error) => Container(),
    );
  }
}

class ImageDisplayWidgetWithSize extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double height;
  final double width;

  const ImageDisplayWidgetWithSize({
    Key key,
    this.url,
    this.fit,
    this.height,
    this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      height: height,
      width: width,
      placeholder: (context, url) => Container(
        height: 100,
        width: 100,
        child: const Center(
            child: Loading(
          size: 40,
        )),
      ),
      errorWidget: (context, url, error) => Container(),
    );
  }
}
