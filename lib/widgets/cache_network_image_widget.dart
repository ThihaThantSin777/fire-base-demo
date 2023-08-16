import 'package:cached_network_image/cached_network_image.dart';
import 'package:fire_base/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class CacheNetworkImageWidget extends StatelessWidget {
  const CacheNetworkImageWidget({super.key, required this.imageURL, this.width, this.height, this.fit});

  final String imageURL;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (_, __) => const LoadingWidget(),
      imageUrl: imageURL,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
