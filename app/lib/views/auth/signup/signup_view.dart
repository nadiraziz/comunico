import 'package:app/controller/auth/auth_controller.dart';
import 'package:app/helper/constant/colors.dart';
import 'package:app/helper/constant/enum.dart';
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

class SignupView extends GetView<AuthController> {
  SignupView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: KImage().fromAsset(
                imagePath: KImagePath.signIn,
                width: 300.w,
                height: 150.h,
              ),
            ),
            signUpForm(),
            signInSection(),
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
    ));
  }

  Row signInSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        KText.body1Text(text: "Already you have account?"),
        KButton().textButton(
          buttonTextWidget: KText.head5Text(
            text: "Sign In",
          ),
          buttonFunc: () {
            AppRouter.goToSignIn();
          },
        )
      ],
    );
  }

  Widget signUpForm() {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (_) {
        return Container(
          padding: KEdgeInset.kVH15,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                kTextFormField(
                  controller: _.userNameController,
                  hintText: "Username",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: "Username is required",
                    ),
                  ]),
                  prefixIcon: Icon(
                    CupertinoIcons.profile_circled,
                    color: KColors.primaryColor,
                  ),
                ),
                kTextFormField(
                  controller: _.emailController,
                  hintText: "Email",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: "Email is required",
                    ),
                    FormBuilderValidators.email(),
                  ]),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: KColors.primaryColor,
                  ),
                ),
                kTextFormField(
                  controller: _.passwordController,
                  hintText: "Password",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: "Password is required",
                    ),
                    FormBuilderValidators.minLength(6),
                  ]),
                  prefixIcon: Icon(
                    CupertinoIcons.lock_circle,
                    color: KColors.primaryColor,
                  ),
                ),
                kTextFormField(
                  controller: _.password2Controller,
                  hintText: "Confirm Password",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: "Password is required",
                    ),
                    FormBuilderValidators.minLength(6),
                  ]),
                  prefixIcon: Icon(
                    CupertinoIcons.lock_circle,
                    color: KColors.primaryColor,
                  ),
                  isPassword: true,
                ),
                Builder(builder: (context) {
                  return kDateTimeFormField(
                      context: context,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      controller: _.dobController,
                      hintText: "Date of Birth");
                }),
                genderSection(),
                Padding(
                  padding: KEdgeInset.kV10,
                  child: KButton().buttonFullWidth(
                    buttonString: "Sign Up",
                    buttonBgColor: KColors.primaryColor,
                    buttonTextColor: Colors.white,
                    buttonFunc: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _.signUp();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget genderSection() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            genderRadioButton(
              value: Gender.male,
              label: "Male",
            ),
            genderRadioButton(
              value: Gender.female,
              label: "Female",
            ),
            genderRadioButton(
              value: Gender.other,
              label: "Other",
            ),
          ],
        ));
  }

  Widget genderRadioButton({required Gender value, required String label}) {
    return Row(
      children: [
        Radio<Gender>(
          value: value,
          groupValue: controller.gender.value,
          onChanged: (value) {
            if (value != null) {
              controller.toggleGender(genderValue: value);
            }
          },
        ),
        KText.body1Text(
          text: label,
        )
      ],
    );
  }
}
