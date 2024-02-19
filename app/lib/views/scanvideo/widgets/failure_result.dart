import 'package:app/helper/constant/appstring.dart';
import 'package:app/helper/constant/imagepath.dart';
import 'package:app/views/common/image_widgets.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:flutter/material.dart';

class FailureResultView extends StatelessWidget {
  const FailureResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              KImage().fromAsset(imagePath: KImagePath.signIn, width: 150),
              const SizedBox(height: 16.0),
              KText.head4Text(text: AppString.somethingWentWrong),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Implement any action you want, like retrying the scan or navigating to another screen.
                },
                child: const Text("Retry"),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Implement any action you want, like navigating to another screen or performing additional tasks.
                },
                child: const Text("Back to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
