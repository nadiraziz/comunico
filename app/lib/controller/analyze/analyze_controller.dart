import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:app/core/api/api_service.dart';
import 'package:app/helper/constant/api_urls.dart';
import 'package:app/helper/constant/appstring.dart';
import 'package:app/helper/routes/approuter.dart';
import 'package:app/models/analyze/analyze_history.dart';
import 'package:app/models/analyze/scanresult.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AnalyzeController extends GetxController {
  Rx<bool> isLoading = false.obs;
  var analyzeHistoryResponse = <AnalyzeHistoryResponse>[].obs;
  ScanResultResponse? scanResult;

  final ImagePicker picker = ImagePicker();

  Future<void> scanVideo({required XFile file}) async {
    isLoading(true);

    try {
      // Make a POST request without a token
      final response = await APIService().postMultipartFile(
        path: APIUrl.scanVideo,
        fieldName: "video",
        file: File(file.path),
      );

      if (response.statusCode == 201) {
        // If the response is successful, parse the data
        ScanResultResponse scanResultResponse =
            ScanResultResponse.fromJson(response.data);
        log(jsonEncode(scanResultResponse));
        scanResult = scanResultResponse;
        log(jsonEncode(scanResult));
        AppRouter.goToSuccessScan();
        isLoading(false);
      } else {
        // Handle failed response
        String errorMessage = response.data['message'];
        Get.snackbar('Sorry', errorMessage, colorText: Colors.red);
        AppRouter.goToFailureScan();
        isLoading(false);
      }
    } catch (e) {
      print(e);
      // Handle failed response
      Get.snackbar(
        'Sorry',
        AppString.somethingWentWrong,
        colorText: Colors.red,
      );
      isLoading(false);
    }
  }

  Future<void> getAnalyzeHistory() async {
    isLoading(true);

    try {
      // Make a POST request without a token
      final response = await APIService().get(
        APIUrl.analyzeHistory,
      );

      if (response.statusCode == 200) {
        // If the response is successful, parse the data
        analyzeHistoryResponse.value =
            analyzeHistoryResponseFromJson(jsonEncode(response.data));
        print(analyzeHistoryResponse);

        isLoading(false);
      } else {
        // Handle failed response
        String errorMessage = response.data['message'];
        Get.snackbar('Sorry', errorMessage, colorText: Colors.red);

        isLoading(false);
      }
    } catch (e) {
      print(e);
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
