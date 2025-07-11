import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class TextBoxDLS extends StatelessWidget {
  const TextBoxDLS({
    super.key,
    this.title = "lorem",
    this.subTitle = "",
    this.description = "",
  });

  final String title, subTitle, description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.r, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: context.appTextTheme.hero,
          ),
          SizedBox(height: 8.h),
          Text(
            subTitle,
            style: context.appTextTheme.h2,
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            style: context.appTextTheme.body,
          ),
        ],
      ),
    );
  }
}
