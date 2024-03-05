import 'dart:convert';

import 'package:app/core/api/api_service.dart';
import 'package:app/helper/constant/api_urls.dart';
import 'package:app/helper/constant/appstring.dart';
import 'package:app/helper/constant/colors.dart';
import 'package:app/models/home/videotips.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<bool> isLoading = false.obs;

  var videoTipsList = <VideoTips>[].obs;

  Future<void> getImproveTipsAndTricks() async {
    isLoading(true);

    // Make a POST request without a token
    final response = await APIService().get(APIUrl.videoTips);

    try {
      if (response.statusCode == 200) {
        videoTipsList.clear();
        // If the response is successful, parse the data
        videoTipsList.value =
            videoTipsResponseFromJson(jsonEncode(response.data));

        isLoading(false);
      } else {
        // Handle failed response
        String errorMessage = response.data['message'];
        Get.snackbar('Sorry', errorMessage, colorText: Colors.red);

        isLoading(false);
      }
    } catch (e) {
      // Handle failed response
      Get.snackbar(
        'Sorry',
        AppString.somethingWentWrong,
        colorText: Colors.red,
      );
      isLoading(false);
    }
  }

  Future<void> sendFeedback({
    required int starCount,
    required String description,
  }) async {
    isLoading(true);

    // Make a POST request without a token
    final response = await APIService().post(
        path: APIUrl.feedback,
        data: {"star_count": starCount, "description": description});

    try {
      if (response.statusCode == 201) {
        Get.snackbar('Thank you', "Thanks for your valuable feedback",
            colorText: Colors.white, backgroundColor: KColors.primaryColor);

        isLoading(false);
      } else {
        // Handle failed response
        String errorMessage = response.data['message'];
        Get.snackbar('Sorry', errorMessage, colorText: Colors.red);

        isLoading(false);
      }
    } catch (e) {
      // Handle failed response
      Get.snackbar(
        'Sorry',
        AppString.somethingWentWrong,
        colorText: Colors.red,
      );
      isLoading(false);
    }
  }
}
