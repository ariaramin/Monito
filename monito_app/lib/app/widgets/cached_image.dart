import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show BoxFit, BuildContext, Center, CircularProgressIndicator, Color, StatelessWidget, Widget;

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.url,
    this.color,
  });

  final String url;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      color: color,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => const SizedBox(),
    );
  }
}
