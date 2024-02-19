import 'package:app/views/analyzehistory/analyzehistory_view.dart';
import 'package:app/views/auth/signin/signin_view.dart';
import 'package:app/views/auth/signup/signup_view.dart';
import 'package:app/views/home/home_view.dart';
import 'package:app/views/profile/profile_view.dart';
import 'package:app/views/scanvideo/scanvideo_view.dart';
import 'package:app/views/scanvideo/widgets/failure_result.dart';
import 'package:app/views/scanvideo/widgets/success_result.dart';
import 'package:app/views/splash/splash_view.dart';
import 'package:get/get.dart';

class AppRouter {
  static final routes = [
    GetPage(name: '/', page: () => const SplashView()),
    GetPage(name: '/home', page: () => const HomeView()),
    GetPage(name: '/signup', page: () => SignupView()),
    GetPage(name: '/signin', page: () => SigninView()),
    GetPage(name: '/analyze-history', page: () => const AnalysisHistoryView()),
    GetPage(name: '/profile', page: () => ProfileView()),
    GetPage(name: '/scan-video', page: () => ScanvideoView()),
    GetPage(name: '/video-success', page: () => const SuccessResultView()),
    GetPage(name: '/video-failure', page: () => const FailureResultView()),
  ];

  static void goToSplash() {
    Get.offAllNamed('/');
  }

  static void goToHome() {
    Get.offAllNamed('/home');
  }

  static void goToSignUp() {
    Get.offNamed('/signup');
  }

  static void goToSignIn() {
    Get.offNamed('/signin');
  }

  static void goToAnalyzeHistory() {
    Get.toNamed('/analyze-history');
  }

  static void goToProfile() {
    Get.toNamed('/profile');
  }

  static void goToScanVideo() {
    Get.toNamed('/scan-video');
  }

  static void goToSuccessScan() {
    Get.toNamed('/video-success');
  }

  static void goToFailureScan() {
    Get.toNamed('/video-failure');
  }
}
