import 'package:app/views/analyze/analyze_view.dart';
import 'package:app/views/auth/signin/signin_view.dart';
import 'package:app/views/auth/signup/signup_view.dart';
import 'package:app/views/home/home_view.dart';
import 'package:app/views/profile/profile_view.dart';
import 'package:get/get.dart';

class AppRouter {
  static final routes = [
    GetPage(name: '/', page: () => const HomeView()),
    GetPage(name: '/signup', page: () => const SignupView()),
    GetPage(name: '/signin', page: () => const SigninView()),
    GetPage(name: '/analyze', page: () => const AnalyzeView()),
    GetPage(name: '/profile', page: () => const ProfileView()),
  ];

  static void goToHome() {
    Get.offAllNamed('/');
  }

  static void goToSignUp() {
    Get.toNamed('/signup');
  }

  static void goToSignIn() {
    Get.toNamed('/signin');
  }

  static void goToAnalyze() {
    Get.toNamed('/analyze');
  }

  static void goToProfile() {
    Get.toNamed('/profile');
  }
}
