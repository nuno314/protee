import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'cache_network_image_wrapper.dart';

class SmartImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final Alignment alignment;

  const SmartImage({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return const SizedBox();
    }
    if (image.contains('http')) {
      return CachedNetworkImageWrapper.item(
        url: image,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
      );
    }
    if (image.contains('svg')) {
      return SvgPicture.asset(
        image,
        width: width,
        height: height,
        color: color,
        alignment: alignment,
      );
    }

    return Image.asset(
      image,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
    );
  }
}
