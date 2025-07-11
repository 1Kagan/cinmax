import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class InformativeText extends StatelessWidget {
  const InformativeText({
    required this.text,
    this.textStyle,
    super.key,
  });

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        border: Border.all(color: AppColorTheme.gray200),
        borderRadius: BorderRadius.circular(8).r,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DLSAssets.icons.infoCircle.svg(width: 24.r),
          12.horizontalSpace,
          Flexible(
            child: Text(
              text,
              style: textStyle ??
                  context.appTextTheme.xSmallRegular
                      ?.copyWith(color: AppColorTheme.darkBg),
            ),
          ),
        ],
      ),
    );
  }
}
