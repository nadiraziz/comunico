// ignore_for_file: invalid_use_of_protected_member

import 'package:app/controller/home/home_controller.dart';
import 'package:app/helper/constant/colors.dart';
import 'package:app/helper/services/youtube.dart';
import 'package:app/helper/utils/borderradius.dart';
import 'package:app/helper/utils/edgeinsert.dart';
import 'package:app/helper/utils/sizedbox.dart';
import 'package:app/models/home/videotips.dart';
import 'package:app/views/common/image_widgets.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/youtube_thumbnail.dart';

class VideotipsView extends StatelessWidget {
  const VideotipsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Tips"),
      ),
      body: SafeArea(
        child: GetX<HomeController>(
          init: HomeController(),
          initState: (_) {
            _.controller?.getImproveTipsAndTricks();
          },
          builder: (controller) {
            if (controller.videoTipsList.isNotEmpty) {
              var videoTipslist =
                  controller.videoTipsList.value.reversed.toList();
              return ListView.builder(
                itemCount: videoTipslist.length,
                itemBuilder: (context, index) {
                  VideoTips videoTip = videoTipslist[index];
                  final videoId = YoutubeService()
                          .convertUrlToId(videoTip.videoLink ?? "") ??
                      "";
                  return Card(
                    margin: KEdgeInset.kVH10,
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        videoTip.videoTitle ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              KColors.secondaryColor, // Change the title color
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            videoTip.videoDescription ?? "",
                            style: TextStyle(
                              color: KColors
                                  .secondaryColor, // Change the subtitle color
                            ),
                          ),
                          KSizedBox.h10,
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: KColors.primaryColor,
                                borderRadius:
                                    KBorderRadius.kAllLR(radius: 10.r)),
                            child: KImage().fromNetwork(
                              imagePath:
                                  YoutubeThumbnail(youtubeId: videoId).mq(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: KText.head4Text(
                              text: "Tap to watch",
                            ),
                          )
                        ],
                      ),
                      tileColor: KColors
                          .primaryColor, // Change the list tile background color
                      onTap: () async {
                        // Handle the tap on the video tip
                        await YoutubeService()
                            .videolaunchUrl(url: videoTip.videoLink ?? "");
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  "No video tips available.",
                  style: TextStyle(
                    color: Colors.red, // Change the text color
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
