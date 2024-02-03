import 'package:app/helper/constant/imagepath.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class KImage {
  Logger logger = Logger();
  Widget fromAsset({
    required String imagePath,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
    Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
  }) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder ??
          (BuildContext context, Object exception, StackTrace? stackTrace) {
            // Return a dummy image widget when an error occurs
            return Image.asset(
              KImagePath.demoImage, // Replace with the path to your dummy image
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
            );
          },
    );
  }

  Widget fromNetwork({
    required String imagePath,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
    Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
  }) {
    return Image.network(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder ??
          (BuildContext context, Object exception, StackTrace? stackTrace) {
            // Return a dummy image widget when an error occurs
            return Image.asset(
              KImagePath.demoImage, // Replace with the path to your dummy image
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
            );
          },
    );
  }

  // Decoration Image widget
  DecorationImage fromDecorationNetworkImage({
    required String imagePath,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
    Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,
  }) {
    return DecorationImage(
      image: NetworkImage(imagePath),
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
      onError: (Object exception, StackTrace? stackTrace) {
        // Log the error
        logger.e('Error Occurred In Decoration Network Image - $imagePath');
      },
    );
  }

  DecorationImage fromDecorationAssetImage({
    required String imagePath,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
    Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,
  }) {
    return DecorationImage(
      image: AssetImage(imagePath),
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
      onError: (Object exception, StackTrace? stackTrace) {
        // Return a dummy image widget when an error occurs
        logger.e('Error Occured In Decoration Network Image - $imagePath');
      },
    );
  }

  DecorationImage assignDecorationNetworkImage({
    required String imagePath,
  }) {
    try {
      if (!imagePath.startsWith('assets')) {
        if (imagePath == "") {
          return fromDecorationAssetImage(
              imagePath: KImagePath.demoImage, fit: BoxFit.cover);
        } else {
          return fromDecorationNetworkImage(
            imagePath: imagePath,
            fit: BoxFit.cover,
          );
        }
      } else {
        return fromDecorationAssetImage(
          imagePath: imagePath,
          fit: BoxFit.cover,
        );
      }
    } catch (e) {
      return fromDecorationAssetImage(
        imagePath: KImagePath.demoImage,
        fit: BoxFit.cover,
      );
    }
  }
}
