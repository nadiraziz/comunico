import 'package:app/helper/constant/colors.dart';
import 'package:app/helper/utils/borderradius.dart';
import 'package:app/helper/utils/edgeinsert.dart';
import 'package:app/helper/utils/textstyle.dart';
import 'package:app/helper/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

Widget kTextFormField({
  required TextEditingController controller,
  Widget? prefixIcon,
  Widget? suffixIcon,
  required String hintText,
  bool? isPassword,
  String? Function(String?)? validator,
  bool? isDisable,
}) {
  return Padding(
      padding: KEdgeInset.kV5,
      child: TextFormField(
        obscureText: isPassword ?? false,
        enabled: isDisable == true ? false : true,
        controller: isDisable != true ? controller : null,
        validator: validator,
        initialValue: isDisable == true ? hintText : null,
        style: KTextStyle.style14.copyWith(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: KEdgeInset.kVH10,
          prefixIcon: prefixIcon,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: KBorderRadius.kAllLR(
              radius: 10.r,
            ),
          ),
          suffixIcon: suffixIcon,
          disabledBorder: OutlineInputBorder(
            borderRadius: KBorderRadius.kAllLR(
              radius: 10.r,
            ),
            borderSide: BorderSide(
              color: KColors.elevatedButtonColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: KBorderRadius.kAllLR(
              radius: 10.r,
            ),
            borderSide: BorderSide(
              color: KColors.elevatedButtonColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: KBorderRadius.kAllLR(
              radius: 10.r,
            ),
            borderSide: BorderSide(
              color: lightTheme.primaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: KBorderRadius.kAllLR(
              radius: 10.r,
            ),
            borderSide: BorderSide(
              color: lightTheme.errorColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: KBorderRadius.kAllLR(
              radius: 10.r,
            ),
            borderSide: BorderSide(
              color: KColors.primaryColor,
            ),
          ),
        ),
      ));
}

Widget kDateTimeFormField({
  required BuildContext context,
  required TextEditingController controller,
  required String hintText,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: KEdgeInset.kV10,
    child: TextFormField(
      controller: controller,
      validator: validator,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null && pickedDate != controller.text) {
          // Update the text field with the selected date formatted as "23 Jan 2023"
          controller.text = DateFormat('dd MMM yyyy').format(pickedDate);
        }
      },
      decoration: InputDecoration(
        contentPadding: KEdgeInset.kVH10,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: KBorderRadius.kAllLR(
            radius: 10.r,
          ),
        ),
        prefixIcon: IconButton(
          onPressed: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (pickedTime != null) {
              // Update the text field with the selected time
              controller.text =
                  // ignore: use_build_context_synchronously
                  '${controller.text} ${pickedTime.format(context)}';
            }
          },
          icon: Icon(
            CupertinoIcons.calendar_circle,
            color: KColors.primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: KBorderRadius.kAllLR(
            radius: 10.r,
          ),
          borderSide: BorderSide(
            color: KColors.elevatedButtonColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: KBorderRadius.kAllLR(
            radius: 10.r,
          ),
          borderSide: BorderSide(
            color: lightTheme.primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: KBorderRadius.kAllLR(
            radius: 10.r,
          ),
          borderSide: BorderSide(
            color: lightTheme.errorColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: KBorderRadius.kAllLR(
            radius: 10.r,
          ),
          borderSide: BorderSide(
            color: KColors.primaryColor,
          ),
        ),
      ),
    ),
  );
}
