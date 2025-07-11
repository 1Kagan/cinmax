import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class TitleTextBoxDLS extends StatelessWidget {
  const TitleTextBoxDLS({
    super.key,
    this.title = "lorem",
    this.subTitle = "ipsum",
  });
  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.r, vertical: 36.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 16.h,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.appTextTheme.hero
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            textAlign: TextAlign.center,
            subTitle,
            style: context.appTextTheme.body,
          ),
        ],
      ),
    );
  }
}
