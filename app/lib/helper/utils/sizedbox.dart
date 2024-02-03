// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Create a class to define constants for SizedBox widgets
class KSizedBox {
  // Heights with specific values
  static SizedBox h10 = SizedBox(
    height: 10.h,
  );
  static SizedBox h20 = SizedBox(
    height: 20.h,
  );
  static SizedBox h30 = SizedBox(
    height: 30.h,
  );
  static SizedBox h40 = SizedBox(
    height: 40.h,
  );
  static SizedBox h50 = SizedBox(
    height: 50.h,
  );

  // Widths with specific values
  static SizedBox w5 = SizedBox(
    width: 5.w,
  );
  static SizedBox w10 = SizedBox(
    width: 10.w,
  );
  static SizedBox w20 = SizedBox(
    width: 20.w,
  );
  static SizedBox w30 = SizedBox(
    width: 30.w,
  );
  static SizedBox w40 = SizedBox(
    width: 40.w,
  );
  static SizedBox w50 = SizedBox(
    width: 50.w,
  );

  // Heights as fractions of the screen height
  static SizedBox h1_8 = SizedBox(
    height: ScreenUtil().screenHeight / 5,
  );
  static SizedBox h1_7 = SizedBox(
    height: ScreenUtil().screenHeight / 5,
  );
  static SizedBox h1_6 = SizedBox(
    height: ScreenUtil().screenHeight / 5,
  );
  static SizedBox h1_5 = SizedBox(
    height: ScreenUtil().screenHeight / 5,
  );
  static SizedBox h1_4 = SizedBox(
    height: ScreenUtil().screenHeight / 4,
  );
  static SizedBox h1_3 = SizedBox(
    height: ScreenUtil().screenHeight / 3,
  );
  static SizedBox h1_2 = SizedBox(
    height: ScreenUtil().screenHeight / 2,
  );

  // Widths as fractions of the screen width
  static SizedBox w1_5 = SizedBox(
    width: ScreenUtil().screenWidth / 5,
  );
  static SizedBox w1_4 = SizedBox(
    width: ScreenUtil().screenWidth / 4,
  );
  static SizedBox w1_3 = SizedBox(
    width: ScreenUtil().screenWidth / 3,
  );
  static SizedBox w1_2 = SizedBox(
    width: ScreenUtil().screenWidth / 2,
  );
}
