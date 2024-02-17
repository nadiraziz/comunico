import 'package:app/controller/auth/auth_controller.dart';
import 'package:app/helper/constant/colors.dart';
import 'package:app/helper/constant/imagepath.dart';
import 'package:app/helper/routes/approuter.dart';
import 'package:app/helper/utils/edgeinsert.dart';
import 'package:app/views/common/buttons_widgets.dart';
import 'package:app/views/common/image_widgets.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:app/views/common/textformfield_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

// View for user sign-in
class SigninView extends GetView<AuthController> {
  SigninView({Key? key}) : super(key: key);

  // Controllers for email and password text fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Form key for validation and form state access
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Scaffold for the main UI structure
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Sign-in image/logo at the center of the screen
              Center(
                child: KImage().fromAsset(
                  imagePath: KImagePath.signIn,
                  width: 300.w,
                  height: 200.h,
                ),
              ),

              // Sign-in form widget
              signInForm(),

              // Section for navigating to the sign-up screen
              registerSection(),

              // App icon/logo at the center of the screen
              Center(
                child: KImage().fromAsset(
                  imagePath: KImagePath.appIcon,
                  width: 100.w,
                  height: 100.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Section for navigating to the sign-up screen
  Row registerSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text prompting the user to sign up
        KText.body1Text(text: "You don't have account?"),

        // Button to navigate to the sign-up screen
        KButton().textButton(
          buttonTextWidget: KText.head5Text(
            text: "Sign up",
          ),
          buttonFunc: () {
            AppRouter.goToSignUp();
          },
        ),
      ],
    );
  }

  // Widget representing the sign-in form
  Widget signInForm() {
    return Container(
      padding: KEdgeInset.kVH15,
      child: Form(
        key:
            _formKey, // Assign the form key for validation and form state access
        child: Column(
          children: <Widget>[
            // Text form field for email input
            kTextFormField(
              controller: emailController,
              hintText: "Email",
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: "Email is required",
                ),
              ]),
              prefixIcon: Icon(
                CupertinoIcons.profile_circled,
                color: KColors.primaryColor,
              ),
            ),

            // Observed text form field for password input
            Obx(
              () => kTextFormField(
                controller: passwordController,
                hintText: "Password",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: "Password is required",
                  ),
                  FormBuilderValidators.minLength(6),
                ]),
                // Password visibility toggle
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.togglePasswordVisibility();
                  },
                  icon: controller.isPasswordVisible.value == true
                      ? const Icon(
                          CupertinoIcons.eye_fill,
                        )
                      : const Icon(
                          CupertinoIcons.eye_slash_fill,
                        ),
                ),
                prefixIcon: Icon(
                  CupertinoIcons.lock_circle,
                  color: KColors.primaryColor,
                ),
                isPassword: controller.isPasswordVisible.value,
              ),
            ),

            // Padding for the sign-in button
            Padding(
                padding: KEdgeInset.kV20,
                // Full-width button for initiating sign-in
                child: Obx(
                  () => KButton().buttonFullWidth(
                    buttonString: "Sign In",
                    buttonBgColor: KColors.primaryColor,
                    buttonTextColor: Colors.white,
                    isLoading: controller.isLoading.value,
                    buttonFunc: () async {
                      // Validate the form before proceeding with login logic
                      if (_formKey.currentState?.validate() ?? false) {
                        await controller.signIn(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
