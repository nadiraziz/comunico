import 'package:app/helper/utils/textstyle.dart';
import 'package:flutter/material.dart';

class KText {
  static Text head1Text({required String text, TextStyle? textStyle}) {
    return Text(
      text,
      style: KTextStyle.style24.copyWith(
        fontWeight: textStyle?.fontWeight ?? FontWeight.w900,
        color: textStyle?.color,
        inherit: textStyle?.inherit,
        backgroundColor: textStyle?.backgroundColor,
        fontSize: textStyle?.fontSize,
        fontStyle: textStyle?.fontStyle,
        letterSpacing: textStyle?.letterSpacing,
        wordSpacing: textStyle?.wordSpacing,
        textBaseline: textStyle?.textBaseline,
        height: textStyle?.height,
        locale: textStyle?.locale,
        foreground: textStyle?.foreground,
        background: textStyle?.background,
        overflow: textStyle?.overflow,
      ),
    );
  }

  static Text head2Text({required String text, TextStyle? textStyle}) {
    return Text(
      text,
      style: KTextStyle.style22.copyWith(
        fontWeight: textStyle?.fontWeight ?? FontWeight.w800,
        color: textStyle?.color,
        inherit: textStyle?.inherit,
        backgroundColor: textStyle?.backgroundColor,
        fontSize: textStyle?.fontSize,
        fontStyle: textStyle?.fontStyle,
        letterSpacing: textStyle?.letterSpacing,
        wordSpacing: textStyle?.wordSpacing,
        textBaseline: textStyle?.textBaseline,
        height: textStyle?.height,
        locale: textStyle?.locale,
        foreground: textStyle?.foreground,
        background: textStyle?.background,
        overflow: textStyle?.overflow,
      ),
    );
  }

  static Text head3Text({required String text, TextStyle? textStyle}) {
    return Text(
      text,
      style: KTextStyle.style20.copyWith(
        fontWeight: textStyle?.fontWeight ?? FontWeight.w700,
        color: textStyle?.color,
        inherit: textStyle?.inherit,
        backgroundColor: textStyle?.backgroundColor,
        fontSize: textStyle?.fontSize,
        fontStyle: textStyle?.fontStyle,
        letterSpacing: textStyle?.letterSpacing,
        wordSpacing: textStyle?.wordSpacing,
        textBaseline: textStyle?.textBaseline,
        height: textStyle?.height,
        locale: textStyle?.locale,
        foreground: textStyle?.foreground,
        background: textStyle?.background,
        overflow: textStyle?.overflow,
      ),
    );
  }

  static Text head4Text({required String text, TextStyle? textStyle}) {
    return Text(
      text,
      style: KTextStyle.style18.copyWith(
        fontWeight: textStyle?.fontWeight ?? FontWeight.w600,
        color: textStyle?.color,
        inherit: textStyle?.inherit,
        backgroundColor: textStyle?.backgroundColor,
        fontSize: textStyle?.fontSize,
        fontStyle: textStyle?.fontStyle,
        letterSpacing: textStyle?.letterSpacing,
        wordSpacing: textStyle?.wordSpacing,
        textBaseline: textStyle?.textBaseline,
        height: textStyle?.height,
        locale: textStyle?.locale,
        foreground: textStyle?.foreground,
        background: textStyle?.background,
        overflow: textStyle?.overflow,
      ),
    );
  }

  static Text head5Text(
      {required String text, TextStyle? textStyle, int? maxlines}) {
    return Text(
      text,
      style: KTextStyle.style16.copyWith(
        fontWeight: textStyle?.fontWeight ?? FontWeight.w500,
        color: textStyle?.color,
        inherit: textStyle?.inherit,
        backgroundColor: textStyle?.backgroundColor,
        fontSize: textStyle?.fontSize,
        fontStyle: textStyle?.fontStyle,
        letterSpacing: textStyle?.letterSpacing,
        wordSpacing: textStyle?.wordSpacing,
        textBaseline: textStyle?.textBaseline,
        height: textStyle?.height,
        locale: textStyle?.locale,
        foreground: textStyle?.foreground,
        background: textStyle?.background,
        overflow: textStyle?.overflow ?? TextOverflow.ellipsis,
      ),
      maxLines: maxlines,
    );
  }

  static Text body1Text({required String text, TextStyle? textStyle}) {
    return Text(
      text,
      style: KTextStyle.style14.copyWith(
        color: textStyle?.color,
        inherit: textStyle?.inherit,
        backgroundColor: textStyle?.backgroundColor,
        fontSize: textStyle?.fontSize,
        fontWeight: textStyle?.fontWeight,
        fontStyle: textStyle?.fontStyle,
        letterSpacing: textStyle?.letterSpacing,
        wordSpacing: textStyle?.wordSpacing,
        textBaseline: textStyle?.textBaseline,
        height: textStyle?.height,
        locale: textStyle?.locale,
        foreground: textStyle?.foreground,
        background: textStyle?.background,
        overflow: textStyle?.overflow,
      ),
    );
  }

  static Widget customText(
      {required String text,
      required TextStyle textStyle,
      TextAlign? textAlign,
      int? maxLines}) {
    return Text(
      text,
      style: textStyle.copyWith(
        fontFamily: "Figtree",
        color: textStyle.color,
        inherit: textStyle.inherit,
        backgroundColor: textStyle.backgroundColor,
        fontSize: textStyle.fontSize,
        fontStyle: textStyle.fontStyle,
        letterSpacing: textStyle.letterSpacing,
        wordSpacing: textStyle.wordSpacing,
        textBaseline: textStyle.textBaseline,
        height: textStyle.height,
        locale: textStyle.locale,
        foreground: textStyle.foreground,
        background: textStyle.background,
        overflow: textStyle.overflow ?? TextOverflow.ellipsis,
      ),
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines,
    );
  }
}
