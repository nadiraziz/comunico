// ignore_for_file: unrelated_type_equality_checks

import 'package:app/controller/sharedpreference/sharedpreference_controller.dart';
import 'package:app/core/api/api_service.dart';
import 'package:app/helper/constant/api_urls.dart';
import 'package:app/helper/constant/appstring.dart';
import 'package:app/helper/constant/enum.dart';
import 'package:app/helper/routes/approuter.dart';
import 'package:app/models/auth/signin_response.dart';
import 'package:app/models/auth/signup_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/helper/extensions/datetime.dart';

class AuthController extends GetxController {
  // Reactive variable to track loading state
  Rx<bool> isLoading = false.obs;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  Rx<Gender> gender = Gender.male.obs;
  // Instance of SharedPreferenceController for handling tokens
  SharedPreferenceController sharedPreferenceController =
      Get.put(SharedPreferenceController());

  // Reactive variable to track the visibility of the password
  RxBool isPasswordVisible = true.obs;

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible(!isPasswordVisible.value);
  }

  // Method to toggle password visibility
  void toggleGender({required Gender genderValue}) {
    gender.value = genderValue;
  }

  // Method to perform user sign-in
  Future<SignInResponse?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);

      // Prepare data for the POST request
      Map<String, String> data = {"email": email, "password": password};

      // Make a POST request without a token
      final response = await APIService(disableToken: true).post(
        path: APIUrl.signIn,
        data: data,
      );

      if (response.statusCode == 200) {
        // If the response is successful, parse the data
        SignInResponse signInResponse = SignInResponse.fromJson(response.data);

        // Save Token to Shared Preferences
        await sharedPreferenceController.saveToken(
          accessToken: signInResponse.accessToken ?? "",
          refreshToken: signInResponse.refreshToken ?? "",
        );
        AppRouter.goToHome();

        isLoading(false);
        return signInResponse;
      } else {
        // Handle failed response
        String errorMessage = response.data['message'];
        Get.snackbar('Sorry', errorMessage, colorText: Colors.red);

        isLoading(false);
        return null;
      }
    } catch (e) {
      // Handle failed response
      Get.snackbar(
        'Sorry',
        AppString.somethingWentWrong,
        colorText: Colors.red,
      );
      isLoading(false);
      return null;
    }
  }

  // Method to perform user sign-up
  Future<SignUpResponse?> signUp() async {
    try {
      isLoading(true);

      // Check if passwords match
      if (passwordController.text != password2Controller.text) {
        // Handle failed response
        Get.snackbar(
          'Sorry, Password is Not Matching',
          AppString.somethingWentWrong,
          colorText: Colors.red,
        );

        isLoading(false);
        return null;
      }

      // Prepare data for the POST request
      Map<String, dynamic> data = {
        "name": userNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "date_of_birth": dobController.text.formatDateString(),
        "gender": Gender.male == gender ? "Male" : "Female",
      };

      // Make a POST request without a token
      final response = await APIService(disableToken: true).post(
        path: APIUrl.signUp,
        data: data,
      );

      if (response.statusCode == 201) {
        // If the response is successful, parse the data
        SignUpResponse signUpResponse = SignUpResponse.fromJson(response.data);

        // Save Token to Shared Preferences
        await sharedPreferenceController.saveToken(
          accessToken: signUpResponse.accessToken ?? "",
          refreshToken: signUpResponse.refreshToken ?? "",
        );
        AppRouter.goToHome();

        isLoading(false);
        return signUpResponse;
      } else {
        // Handle failed response
        String errorMessage = response.data['message'];
        Get.snackbar('Sorry', errorMessage, colorText: Colors.red);

        isLoading(false);
        return null;
      }
    } catch (e) {
      // Handle failed response
      Get.snackbar(
        'Sorry',
        AppString.somethingWentWrong,
        colorText: Colors.red,
      );
      isLoading(false);
      return null;
    }
  }

  Future<String?> updateAccessToken() async {
    try {
      isLoading(true);

      // Make a POST request without a token
      final response = await APIService(disableToken: true).post(
        path: APIUrl.refreshToken,
        data: {"refresh": sharedPreferenceController.getRefreshToken()},
      );

      if (response.statusCode == 200) {
        String accessToken = response.data["access"];
        // Save Token to Shared Preferences
        await sharedPreferenceController.saveToken(
          accessToken: accessToken,
        );

        isLoading(false);
        return accessToken;
      } else {
        // Handle failed response
        String errorMessage = response.data['message'];
        Get.snackbar('Sorry', errorMessage, colorText: Colors.red);

        isLoading(false);
        return null;
      }
    } catch (e) {
      // Handle failed response
      Get.snackbar(
        'Sorry',
        AppString.somethingWentWrong,
        colorText: Colors.red,
      );
      isLoading(false);
      return null;
    }
  }
}
