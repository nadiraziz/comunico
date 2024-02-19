import 'dart:io';

import 'package:app/controller/analyze/analyze_controller.dart';
import 'package:app/helper/constant/colors.dart';
import 'package:app/helper/constant/imagepath.dart';
import 'package:app/helper/utils/edgeinsert.dart';
import 'package:app/helper/utils/sizedbox.dart';
import 'package:app/views/common/buttons_widgets.dart';
import 'package:app/views/common/image_widgets.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ScanvideoView extends StatefulWidget {
  ScanvideoView({Key? key}) : super(key: key);

  @override
  State<ScanvideoView> createState() => _ScanvideoViewState();
}

class _ScanvideoViewState extends State<ScanvideoView> {
  XFile? videoFile;

  AnalyzeController controller = Get.find();

  String? videoThumbnail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: KText.head5Text(text: "Scan Video"),
      ),
      body: SafeArea(
        minimum: KEdgeInset.kVH15,
        child: Column(
          children: [
            KImage().fromAsset(imagePath: KImagePath.scan, width: 300.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (videoFile == null)
                  KButton().buttonFullWidth(
                    buttonString: "Upload Video",
                    buttonBgColor: KColors.primaryColor,
                    buttonTextColor: KColors.secondaryColor,
                    buttonFunc: () async {
                      // await controller.uploadFile();
                      videoFile = await controller.picker
                          .pickVideo(source: ImageSource.gallery);
                      videoThumbnail = await VideoThumbnail.thumbnailFile(
                        video: videoFile?.path ?? "",
                        imageFormat: ImageFormat.JPEG,
                        maxWidth:
                            128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                        quality: 25,
                      );
                      setState(() {});
                    },
                  ),
                KSizedBox.h30,
                if (videoThumbnail != null)
                  KImage().fromAsset(
                    imagePath: videoThumbnail!,
                    width: 300.w,
                  ),
                Obx(() => KButton().buttonFullWidth(
                      isLoading: controller.isLoading.value,
                      isMute: videoFile != null ? false : true,
                      buttonString: "Scan Video",
                      buttonBgColor: KColors.primaryColor,
                      buttonTextColor: KColors.secondaryColor,
                      buttonFunc: () async {
                        if (videoFile != null) {
                          controller.scanVideo(file: videoFile!);
                        }
                      },
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
