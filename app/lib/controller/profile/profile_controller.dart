import 'package:app/helper/constant/enum.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Future<void> getProfile() async {}

  Future<void> updateProfile({
    required String username,
    required String password,
    required DateTime dateOfBirth,
    required Gender gender,
  }) async {}

  Future<void> deleteAccount() async {}
}
