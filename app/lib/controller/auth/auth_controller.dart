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

class AuthController extends GetxController {
  // Reactive variable to track loading state
  Rx<bool> isLoading = false.obs;

  // Instance of SharedPreferenceController for handling tokens
  SharedPreferenceController sharedPreferenceController =
      Get.put(SharedPreferenceController());

  // Reactive variable to track the visibility of the password
  RxBool isPasswordVisible = true.obs;

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible(!isPasswordVisible.value);
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
      final response = await APIService().post(
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
  Future<SignUpResponse?> signUp({
    required String name,
    required String email,
    required String pass1,
    required String pass2,
    required DateTime dateOfBirth,
    required Gender gender,
  }) async {
    try {
      isLoading(true);

      // Check if passwords match
      if (pass1 == pass2) {
        // Prepare data for the POST request
        Map<String, dynamic> data = {
          "name": name,
          "email": email,
          "password": pass1,
          "date_of_birth": dateOfBirth,
          "gender": Gender.male == gender ? "Male" : "Female",
        };

        // Make a POST request without a token
        final response = await APIService().post(
          path: APIUrl.signIn,
          data: data,
        );

        if (response.statusCode == 201) {
          // If the response is successful, parse the data
          SignUpResponse signUpResponse =
              SignUpResponse.fromJson(response.data);

          // Save Token to Shared Preferences
          await sharedPreferenceController.saveToken(
            accessToken: signUpResponse.accessToken ?? "",
            refreshToken: signUpResponse.refreshToken ?? "",
          );

          isLoading(false);
          return signUpResponse;
        } else {
          // Handle failed response
          String errorMessage = response.data['message'];
          Get.snackbar('Sorry', errorMessage, colorText: Colors.red);

          isLoading(false);
          return null;
        }
      } else {
        // Handle failed response
        Get.snackbar(
          'Sorry',
          AppString.somethingWentWrong,
          colorText: Colors.red,
        );

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
