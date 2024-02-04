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

class SigninView extends StatelessWidget {
  SigninView({Key? key}) : super(key: key);

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                height: 200.h,
              ),
            ),
            signInForm(),
            registerSection(),
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

  Row registerSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        KText.body1Text(text: "You don't have account?"),
        KButton().textButton(
          buttonTextWidget: KText.head5Text(
            text: "Sign up",
          ),
          buttonFunc: () {
            AppRouter.goToSignUp();
          },
        )
      ],
    );
  }

  Widget signInForm() {
    return Container(
      padding: KEdgeInset.kVH15,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            kTextFormField(
              controller: userNameController,
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
              controller: passwordController,
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
              isPassword: true,
            ),
            Padding(
              padding: KEdgeInset.kV20,
              child: KButton().buttonFullWidth(
                buttonString: "Sign In",
                buttonBgColor: KColors.primaryColor,
                buttonTextColor: Colors.white,
                buttonFunc: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Form is valid, proceed with login logic
                    // You can access form field values using:
                    // userNameController.text and passwordController.text
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
