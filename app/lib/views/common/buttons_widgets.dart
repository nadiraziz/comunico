import 'package:app/helper/constant/colors.dart';
import 'package:app/helper/utils/borderradius.dart';
import 'package:app/helper/utils/edgeinsert.dart';
import 'package:app/helper/utils/textstyle.dart';
import 'package:app/views/common/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_widgets.dart';

class KButton {
  Widget elevated({
    required Widget buttonTextwidget,
    required Function buttonFunc,
    bool isMuted = false, // Added boolean argument for muting/unmuting
    Color? bgColor,
  }) {
    bgColor = bgColor ?? KColors.elevatedButtonColor;
    return Container(
      decoration: BoxDecoration(
        color:
            !isMuted ? bgColor : KColors.muteColor, // Use grey color if muted
        borderRadius: KBorderRadius.kAllLR(radius: 10.r),
      ),
      child: TextButton(
        onPressed: isMuted
            ? null
            : () {
                buttonFunc();
              },
        child: buttonTextwidget,
      ),
    );
  }

  Widget textButton({
    required Widget buttonTextWidget,
    required Function buttonFunc,
    bool isMuted = false, // Added boolean argument for muting/unmuting
  }) {
    return TextButton(
      onPressed: isMuted
          ? null
          : () {
              buttonFunc();
            },
      child: buttonTextWidget,
    );
  }

  Widget outlined({
    required Widget buttonTextWidget,
    required Function buttonFunc,
    bool isMuted = false, // Added boolean argument for muting/unmuting
    Color? outLineBorderColor,
  }) {
    outLineBorderColor = outLineBorderColor ?? KColors.elevatedButtonColor;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: !isMuted ? outLineBorderColor : KColors.muteColor,
        ), // Use grey color if muted
        borderRadius: KBorderRadius.kAllLR(radius: 10.r),
      ),
      child: TextButton(
        onPressed: isMuted
            ? null
            : () {
                buttonFunc();
              },
        child: buttonTextWidget,
      ),
    );
  }

  Widget roundedOutlined({
    required Widget buttonTextWidget,
    required Function buttonFunc,
    bool isMuted = false, // Added boolean argument for muting/unmuting
    Color? outLineBorderColor,
  }) {
    outLineBorderColor = outLineBorderColor ?? KColors.elevatedButtonColor;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: !isMuted ? outLineBorderColor : KColors.muteColor,
        ), // Use grey color if muted
        borderRadius: KBorderRadius.kAllLR(radius: 50.r),
      ),
      child: TextButton(
        onPressed: !isMuted
            ? null
            : () {
                buttonFunc();
              },
        child: buttonTextWidget,
      ),
    );
  }

  Widget buttonFullWidth({
    required String buttonString,
    required Color buttonBgColor,
    required Color buttonTextColor,
    required Function buttonFunc,
    bool? isLoading,
    bool? isMute,
  }) {
    return SizedBox(
      width: double.infinity,
      child: elevated(
        isMuted: isLoading ?? isMute ?? false,
        bgColor: buttonBgColor,
        buttonTextwidget: isLoading == true
            ? kLoadingCircularWidget(color: buttonTextColor)
            : KText.customText(
                text: buttonString,
                textStyle: KTextStyle.style18.copyWith(
                  color: buttonTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
        buttonFunc: () async {
          buttonFunc();
        },
      ),
    );
  }

  Widget bottomNavbuttonFullWidth({
    required String buttonString,
    required Color buttonBgColor,
    required Color buttonTextColor,
    required Function buttonFunc,
    bool? isMute,
    bool? isloading,
  }) {
    return SafeArea(
      child: Container(
        padding: KEdgeInset.kVH15,
        child: KButton().elevated(
          isMuted: isloading ?? isMute ?? false,
          bgColor: isMute == true ? KColors.muteColor : buttonBgColor,
          buttonTextwidget: isloading == true
              ? kLoadingCircularWidget()
              : KText.customText(
                  text: buttonString,
                  textStyle: KTextStyle.style18.copyWith(
                    color: buttonTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
          buttonFunc: () {
            if (isMute != true) {
              buttonFunc();
            }
          },
        ),
      ),
    );
  }

  // loading button
  Widget loadingButton() {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: KColors.elevatedButtonColor,
        borderRadius: KBorderRadius.kAllLR(radius: 10.r),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: KColors.secondaryColor,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget linkTextButton({
    required Widget buttonTextWidget,
    required Function buttonFunc,
    bool isMuted = false, // Added boolean argument for muting/unmuting
  }) {
    return GestureDetector(
      onTap: isMuted
          ? null
          : () {
              buttonFunc();
            },
      child: buttonTextWidget,
    );
  }
}
