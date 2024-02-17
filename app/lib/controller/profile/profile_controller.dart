import 'package:app/core/api/api_service.dart';
import 'package:app/helper/constant/api_urls.dart';
import 'package:app/helper/constant/appstring.dart';
import 'package:app/models/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<ProfileResponse?> profileData = ProfileResponse().obs;

  Future<ProfileResponse?> getProfile() async {
    isLoading(true);

    // Make a POST request without a token
    final response = await APIService().get(APIUrl.profile);

    try {
      if (response.statusCode == 200) {
        // If the response is successful, parse the data
        ProfileResponse profileResponse =
            ProfileResponse.fromJson(response.data);

        profileData.value = profileResponse;
        isLoading(false);
        return profileResponse;
      } else {
        // Handle failed response
        String errorMessage = response.data['message'];
        Get.snackbar('Sorry', errorMessage, colorText: Colors.red);

        isLoading(false);
        return null;
      }
    } catch (e) {
      // Handle failed response
      Get.snackbar(
        'Sorry',
        AppString.somethingWentWrong,
        colorText: Colors.red,
      );
      isLoading(false);
      return null;
    }
  }
}
