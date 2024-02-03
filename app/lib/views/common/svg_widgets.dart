// ignore_for_file: deprecated_member_use

import 'package:app/helper/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class KSvg {
  static Widget svgAsset(
      {required String assetPath,
      String? semanticsLabel,
      double? width,
      double? height,
      BoxFit? boxFit}) {
    return SizedBox(
      width: width,
      height: height,
      child: SvgPicture.asset(
        assetPath,
        semanticsLabel: semanticsLabel,
        fit: boxFit ?? BoxFit.contain,
        // placeholderBuilder: (BuildContext context) => ConstrainedBox(
        //   constraints: BoxConstraints(
        //     maxWidth: 20.w,
        //     maxHeight: 20.h,
        //   ),
        //   child: FittedBox(
        //     child: CircularProgressIndicator(
        //       color: KColor.primaryColor,
        //       strokeWidth: 1,
        //     ),
        //   ),
        // ),
      ),
    );
  }

  static Widget svgNetwork(
      {required String networkPath,
      String? semanticsLabel,
      double? width,
      double? height,
      BoxFit? boxFit}) {
    return SvgPicture.network(
      networkPath,
      semanticsLabel: semanticsLabel,
      placeholderBuilder: (BuildContext context) => Container(
          padding: const EdgeInsets.all(30.0),
          child: CircularProgressIndicator(
            color: KColors.primaryColor,
          )),
      width: width,
      height: height,
      fit: boxFit ?? BoxFit.contain,
    );
  }

  static Widget svgIconAsset(
      {required String assetPath,
      String? semanticsLabel,
      required double width,
      required double height,
      Color? color,
      BoxFit? boxFit,
      bool muteColor = false}) {
    return SizedBox(
      child: SvgPicture.asset(
        assetPath,
        semanticsLabel: semanticsLabel,
        fit: BoxFit.scaleDown,
        width: width,
        height: height,

        color: muteColor ? null : color, // Check the muteColor flag
      ),
    );
  }
}
