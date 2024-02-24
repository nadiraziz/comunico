// ignore_for_file: invalid_use_of_protected_member

import 'package:app/controller/home/home_controller.dart';
import 'package:app/controller/profile/profile_controller.dart';
import 'package:app/helper/constant/colors.dart';
import 'package:app/helper/routes/approuter.dart';
import 'package:app/helper/utils/borderradius.dart';
import 'package:app/helper/utils/edgeinsert.dart';
import 'package:app/helper/utils/sizedbox.dart';
import 'package:app/helper/utils/textstyle.dart';
import 'package:app/views/common/image_widgets.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wave/wave.dart';

import 'package:wave/config.dart';
import 'package:youtube_scrape_api/youtube_scrape_api.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            titleSection(),
            KSizedBox.h10,
            carouselVideoTips(context),
            KSizedBox.h10,
            Container(
              margin: KEdgeInset.kVH10,
              padding: KEdgeInset.kH10,
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: KBorderRadius.kAllLR(radius: 10.r),
                border: Border.all(
                  color: KColors.primaryColor,
                  width: 5.h,
                ),
              ),
            ),
            featuresTab(),
          ],
        ),
      ),
    );
  }

  Widget carouselVideoTips(context) {
    return GetX<HomeController>(
      init: HomeController(),
      initState: (_) {
        _.controller?.getImproveTipsAndTricks();
      },
      builder: (controller) {
        if (controller.videoTipsList.isEmpty) {
          return const SizedBox();
        } else if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              viewportFraction:
                  controller.videoTipsList.length == 1 ? 0.95 : 0.8,
              enableInfiniteScroll:
                  controller.videoTipsList.length == 1 ? false : true,
              reverse: controller.videoTipsList.length == 1 ? false : true,
              autoPlay: controller.videoTipsList.length == 1 ? false : true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage:
                  controller.videoTipsList.length == 1 ? false : true,
              enlargeFactor: 0.3,
            ),
            items: controller.videoTipsList.value.map((i) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: KColors.primaryColor,
                      borderRadius: KBorderRadius.kAllLR(radius: 10.r)),
                  child: Text(
                    'text $i',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget featuresTab() {
    return Padding(
      padding: KEdgeInset.kVH10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconTabWidget(
            title: "Scan Video",
            icon: Icons.document_scanner,
            function: () {
              AppRouter.goToScanVideo();
            },
          ),
          KSizedBox.w10,
          iconTabWidget(
            title: "Analyze History",
            icon: Icons.history_edu,
            function: () {
              AppRouter.goToAnalyzeHistory();
            },
          ),
        ],
      ),
    );
  }

  Widget iconTabWidget({
    required String title,
    required IconData icon,
    required Function function,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          function();
        },
        child: Container(
          height: 100.h,
          padding: KEdgeInset.kVH10,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: KColors.primaryColor,
              borderRadius: KBorderRadius.kAllLR(radius: 10.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: KColors.secondaryColor,
              ),
              KText.customText(
                text: title,
                textStyle: KTextStyle.style16.copyWith(
                  color: KColors.secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleSection() {
    return Padding(
      padding: KEdgeInset.kVH10,
      child: Row(
        children: [
          GetX<ProfileController>(
            init: ProfileController(),
            initState: (_) {
              _.controller?.getProfile();
            },
            builder: (_) {
              if (_.profileData.value != null) {
                return SizedBox(
                  width: 200.w,
                  child: KText.customText(
                    text: "Hi ${_.profileData.value?.name}",
                    textStyle: KTextStyle.style26.copyWith(
                      color: KColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                  ),
                );
              } else if (_.isLoading.value) {
                return SizedBox(
                  width: 50.w,
                  height: 50.h,
                  child: const CircularProgressIndicator(),
                );
              }
              return const SizedBox();
            },
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
      ),
    );
  }
}
