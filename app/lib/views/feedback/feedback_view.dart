import 'package:app/controller/home/home_controller.dart';
import 'package:app/helper/constant/colors.dart';
import 'package:app/helper/utils/edgeinsert.dart';
import 'package:app/helper/utils/sizedbox.dart';
import 'package:app/helper/utils/textstyle.dart';
import 'package:app/views/common/buttons_widgets.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:app/views/common/textformfield_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class FeedbackView extends GetView<HomeController> {
  FeedbackView({Key? key}) : super(key: key);

  TextEditingController descriptionController = TextEditingController();
  // Form key for validation and form state access
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double ratingCount = 2.5;
    return Scaffold(
      appBar: AppBar(
        title: KText.customText(
          text: "Feedback",
          textStyle: KTextStyle.style14,
        ),
      ),
      body: SafeArea(
        minimum: KEdgeInset.kH20,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              KText.customText(
                text: "How is communico?",
                textStyle: KTextStyle.style18.copyWith(
                  color: KColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              KSizedBox.h20,
              RatingBar.builder(
                initialRating: ratingCount,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: KEdgeInset.kH5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  ratingCount = rating;
                },
              ),
              KSizedBox.h20,
              kTextFormField(
                controller: descriptionController,
                hintText: "Description",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: "Description is required",
                  ),
                ]),
                maxLines: 4,
              ),
              KSizedBox.h40,
              KButton().buttonFullWidth(
                buttonString: "Submit",
                buttonBgColor: KColors.primaryColor,
                buttonTextColor: KColors.secondaryColor,
                buttonFunc: () {
                  if (_formKey.currentState?.validate() == true) {
                    controller.sendFeedback(
                      starCount: ratingCount.round(),
                      description: descriptionController.text,
                    );
                    Get.back();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
