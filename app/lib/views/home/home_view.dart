import 'package:app/helper/constant/colors.dart';
import 'package:app/helper/routes/approuter.dart';
import 'package:app/helper/utils/edgeinsert.dart';
import 'package:app/helper/utils/textstyle.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: KEdgeInset.kVH10,
          child: Column(
            children: <Widget>[
              titleSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleSection() {
    return Row(
      children: [
        SizedBox(
          width: 200.w,
          child: KText.customText(
            text: "Hi Shermina",
            textStyle: KTextStyle.style26.copyWith(
              color: KColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
            maxLines: 1,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            AppRouter.goToProfile();
          },
          icon: Icon(
            CupertinoIcons.profile_circled,
            size: 35.sp,
            color: KColors.primaryColor,
          ),
        )
      ],
    );
  }
}
