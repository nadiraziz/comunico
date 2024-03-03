import 'package:app/helper/constant/imagepath.dart';
import 'package:app/views/common/image_widgets.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataNotFoundWidget extends StatelessWidget {
  const DataNotFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: KImage().fromAsset(
            imagePath: KImagePath.notFound,
            width: 200.w,
          ),
        ),
        KText.head3Text(text: "Data Not Found")
      ],
    );
  }
}
