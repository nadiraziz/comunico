// ignore_for_file: must_be_immutable

import 'package:app/controller/profile/profile_controller.dart';
import 'package:app/controller/sharedpreference/sharedpreference_controller.dart';
import 'package:app/helper/constant/colors.dart';
import 'package:app/helper/extensions/datetime.dart';
import 'package:app/helper/utils/borderradius.dart';
import 'package:app/helper/utils/edgeinsert.dart';
import 'package:app/helper/utils/sizedbox.dart';
import 'package:app/helper/utils/textstyle.dart';
import 'package:app/views/common/buttons_widgets.dart';
import 'package:app/views/common/loading_widgets.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:app/views/common/textformfield_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  TextEditingController userNamecontroller = TextEditingController();
  TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.find();
    controller.getProfile();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: KEdgeInset.kVH15,
        child: Obx(() {
          if (controller.isLoading.value == true) {
            return Center(child: kLoadingCircularWidget());
          } else if (controller.profileData.value != null) {
            final profileData = controller.profileData;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleSection(),
                KSizedBox.h30,
                profileField(
                  label: "Username",
                  value: profileData.value?.name ?? "Not Provided",
                ),
                profileField(
                  label: "Date of Birth",
                  value: profileData.value!.dateOfBirth?.formattedDate() ??
                      "Not Provided",
                ),
                profileField(
                  label: "Gender",
                  value: profileData.value?.gender ?? "Not Provided",
                ),
                KSizedBox.h30,
                KButton().buttonFullWidth(
                  buttonString: "Logout",
                  buttonBgColor: KColors.primaryColor,
                  buttonTextColor: Colors.white,
                  buttonFunc: () async {
                    await SharedPreferenceController().logOut();
                  },
                )
              ],
            );
          }
          return const SizedBox();
        }),
      )),
    );
  }

  Widget profileField({required String label, required String value}) {
    return Padding(
      padding: KEdgeInset.kV5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KText.customText(
            text: label,
            textStyle: KTextStyle.style16.copyWith(
              color: KColors.primaryColor,
            ),
            textAlign: TextAlign.left,
          ),
          kTextFormField(
            controller: userNamecontroller,
            hintText: value,
            isDisable: true,
          )
        ],
      ),
    );
  }

  Widget titleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: KColors.primaryColor,
            borderRadius: KBorderRadius.kAllLR(radius: 20.r),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                CupertinoIcons.chevron_back,
                color: Colors.white,
                size: 25.sp,
              ),
            ),
          ),
        ),
        KSizedBox.w10,
        KText.customText(
          text: "Profile",
          textStyle: KTextStyle.style26.copyWith(
            color: KColors.primaryColor,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
          maxLines: 1,
        ),
      ],
    );
  }
}
