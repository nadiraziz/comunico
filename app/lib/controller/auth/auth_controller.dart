import 'package:app/helper/constant/enum.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Future<void> signin({
    required String username,
    required String password,
  }) async {}

  Future<void> signup({
    required String username,
    required String pass1,
    required String pass2,
    required DateTime dateOfBirth,
    required Gender gender,
  }) async {}
}
