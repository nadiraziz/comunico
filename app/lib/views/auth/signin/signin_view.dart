import 'package:app/helper/constant/colors.dart';
import 'package:app/helper/constant/iconpath.dart';
import 'package:app/helper/utils/textstyle.dart';
import 'package:app/views/common/svg_widgets.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:flutter/material.dart';

class SigninView extends StatelessWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          KSvg.svgAsset(
            assetPath: KIconPath.signIn,
          ),
          SizedBox(
            child: KText.customText(
              text: "Welcome Back",
              textStyle: KTextStyle.style22.copyWith(
                color: KColors.primaryColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
              maxLines: 1,
            ),
          ),
        ],
      ),
    ));
  }
}
