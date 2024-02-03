import 'package:flutter/material.dart';

// Create a class for defining different BorderRadius configurations
class KBorderRadius {
  // Method to create BorderRadius with the same radius for all corners
  static BorderRadius kAllLR({required double radius}) {
    return BorderRadius.all(Radius.circular(radius));
  }

  // Method to create BorderRadius with different radii for top-left and top-right corners
  static BorderRadius kTopLR({
    required double leftRadius,
    required double rightRadius,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(leftRadius),
      topRight: Radius.circular(rightRadius),
    );
  }

  // Method to create BorderRadius with different radii for bottom-left and bottom-right corners
  static BorderRadius kBottomLR({
    required double leftRadius,
    required double rightRadius,
  }) {
    return BorderRadius.only(
      bottomLeft: Radius.circular(leftRadius),
      bottomRight: Radius.circular(rightRadius),
    );
  }

  // Method to create BorderRadius with different radii for bottom-left and bottom-right corners
  static BorderRadius kRSide({
    required double radius,
  }) {
    return BorderRadius.only(
      topRight: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );
  }

  // Method to create BorderRadius with different radii for all corners

  static BorderRadius kTopBottomLR(
      {required double topLeftRadius,
      required double topRightRadius,
      required double botttomLeftRadius,
      required double botttomRightRadius}) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeftRadius),
      topRight: Radius.circular(topRightRadius),
      bottomLeft: Radius.circular(botttomLeftRadius),
      bottomRight: Radius.circular(botttomRightRadius),
    );
  }
}
