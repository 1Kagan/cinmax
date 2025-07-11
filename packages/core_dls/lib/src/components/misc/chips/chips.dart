import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class Chips extends StatelessWidget {
  const Chips({
    super.key,
    required this.chipText,
  });

  final String chipText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23.r,
      width: 74.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45.r),
        color: AppColorTheme.negative,
      ),
      child: Text(
        chipText,
        style: context.appTextTheme.miniLabel?.copyWith(
          color: AppColorTheme.pureWhite,
        ),
      ),
    );
  }
}
