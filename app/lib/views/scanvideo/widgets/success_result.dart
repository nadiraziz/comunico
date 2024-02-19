import 'package:app/helper/routes/approuter.dart';
import 'package:app/helper/utils/edgeinsert.dart';
import 'package:app/models/analyze/scanresult.dart';
import 'package:flutter/material.dart';
import 'package:app/controller/analyze/analyze_controller.dart';
import 'package:app/helper/constant/appstring.dart';
import 'package:app/helper/constant/imagepath.dart';
import 'package:app/views/common/image_widgets.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuccessResultView extends GetView<AnalyzeController> {
  const SuccessResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              KText.head3Text(text: "Video Scan Result"),
              const SizedBox(height: 16.0),
              KImage().fromAsset(imagePath: KImagePath.scan, width: 100),
              const SizedBox(height: 16.0),
              if (controller.scanResult != null) _buildResultCard(),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Implement any action you want, like navigating to another screen or performing additional tasks.
                  AppRouter.goToHome();
                },
                child: const Text("Back to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    final result = controller.scanResult;
    return Card(
      elevation: 4.0,
      margin: KEdgeInset.kVH15,
      child: Padding(
        padding: KEdgeInset.kVH15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            KText.head5Text(text: "Emotion Analysis"),
            SizedBox(height: 8.0.h),
            _buildResultItem(
                "Voice Emotion", result?.voiceEmotion ?? AppString.notProvided),
            _buildResultItem(
                "Face Emotion", result?.faceEmotion ?? AppString.notProvided),
            SizedBox(height: 16.0.h),
            KText.head5Text(text: "Feedback"),
            SizedBox(height: 8.0.h),
            KText.body1Text(text: result?.feedback ?? AppString.notProvided),
            SizedBox(height: 8.0.h),
            KText.head5Text(text: "Additional Feedback"),
            SizedBox(height: 8.0.h),
            KText.body1Text(
                text: result?.additionalFeedback ?? AppString.notProvided),
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        KText.body1Text(text: label),
        KText.head5Text(text: value),
      ],
    );
  }
}
