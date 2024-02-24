import 'package:app/controller/analyze/analyze_controller.dart';
import 'package:app/controller/auth/auth_controller.dart';
import 'package:app/controller/home/home_controller.dart';
import 'package:app/controller/profile/profile_controller.dart';
import 'package:app/core/api/api_service.dart';
import 'package:get/get.dart';
import 'package:app/controller/sharedpreference/sharedpreference_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // Bind APIService and SharedPreferenceController to the corresponding classes
    Get.put<AuthController>(AuthController());
    Get.put<SharedPreferenceController>(SharedPreferenceController());
    Get.put<APIService>(APIService());
    Get.put<ProfileController>(ProfileController());
    Get.put<AnalyzeController>(AnalyzeController());
    Get.put<HomeController>(HomeController());
  }
}
