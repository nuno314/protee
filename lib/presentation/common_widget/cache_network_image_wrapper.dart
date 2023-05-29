import 'package:flutter/material.dart';
import '../../generated/assets.dart';
import 'export.dart';

export 'package:cached_network_image/cached_network_image.dart';

class CachedNetworkImageWrapper extends CachedNetworkImage {
  CachedNetworkImageWrapper({
    Key? key,
    required String url,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
    double loadingRadius = 10,
  }) : super(
          key: key,
          alignment: alignment,
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => Loading(
            brightness: Brightness.light,
            radius: loadingRadius,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );

  CachedNetworkImageWrapper.avatar({
    Key? key,
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
    Alignment alignment = Alignment.center,
  }) : super(
          key: key,
          alignment: alignment,
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => const Loading(
            brightness: Brightness.light,
            radius: 10,
          ),
          errorWidget: (context, url, error) => SmartImage(
            image: Assets.image.logoFilled,
            width: width ?? 40,
            height: height ?? 40,
          ),
        );

  CachedNetworkImageWrapper.item({
    Key? key,
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    String? placeHolder,
    Alignment alignment = Alignment.center,
  }) : super(
          key: key,
          alignment: alignment,
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          color: color,
          maxHeightDiskCache: 200,
          maxWidthDiskCache: 200,
          placeholder: (context, url) {
            if (placeHolder == null) {
              return const Loading(
                brightness: Brightness.light,
                radius: 10,
              );
            }
            return SmartImage(
              image: placeHolder,
              width: width,
              height: height,
              fit: fit,
            );
          },
          errorWidget: (context, url, error) {
            return SmartImage(
              image: placeHolder ?? Assets.image.logo,
              width: width,
              height: height,
              fit: fit,
            );
          },
        );

  CachedNetworkImageWrapper.banner({
    Key? key,
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
    String? placeHolder,
    Alignment alignment = Alignment.center,
  }) : super(
          key: key,
          alignment: alignment,
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) {
            if (placeHolder == null) {
              return const Loading(
                brightness: Brightness.light,
                radius: 10,
              );
            }
            return SmartImage(
              image: placeHolder,
              width: width,
              height: height,
              fit: fit,
            );
          },
          errorWidget: (context, url, error) {
            return SmartImage(
              image: placeHolder ?? Assets.image.logo,
              width: width,
              height: height,
              fit: fit,
            );
          },
        );

  CachedNetworkImageWrapper.background({
    Key? key,
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
    Alignment alignment = Alignment.center,
  }) : super(
          key: key,
          alignment: alignment,
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => const Loading(
            brightness: Brightness.light,
            radius: 10,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
}
