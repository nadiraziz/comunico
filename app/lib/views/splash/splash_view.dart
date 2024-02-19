import 'package:app/controller/sharedpreference/sharedpreference_controller.dart';
import 'package:app/helper/constant/imagepath.dart';
import 'package:app/helper/routes/approuter.dart';
import 'package:app/views/common/image_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      if (SharedPreferenceController().isUserLogged()) {
        AppRouter.goToHome();
      } else {
        AppRouter.goToSignIn();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: KImage().fromAsset(
            imagePath: KImagePath.appIcon,
            width: 300.w,
          ),
        ),
      ),
    );
  }
}
