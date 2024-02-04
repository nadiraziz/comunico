import 'package:app/views/analyze/analyze_view.dart';
import 'package:app/views/auth/signin/signin_view.dart';
import 'package:app/views/auth/signup/signup_view.dart';
import 'package:app/views/home/home_view.dart';
import 'package:app/views/profile/profile_view.dart';
import 'package:get/get.dart';

class AppRouter {
  static final routes = [
    GetPage(name: '/', page: () => const HomeView()),
    GetPage(name: '/signup', page: () => SignupView()),
    GetPage(name: '/signin', page: () => SigninView()),
    GetPage(name: '/analyze', page: () => const AnalyzeView()),
    GetPage(name: '/profile', page: () => ProfileView()),
  ];

  static void goToHome() {
    Get.offAllNamed('/');
  }

  static void goToSignUp() {
    Get.offNamed('/signup');
  }

  static void goToSignIn() {
    Get.offNamed('/signin');
  }

  static void goToAnalyze() {
    Get.toNamed('/analyze');
  }

  static void goToProfile() {
    Get.toNamed('/profile');
  }
}
