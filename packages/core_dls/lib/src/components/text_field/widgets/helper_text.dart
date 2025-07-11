import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class HelperText extends StatelessWidget {
  const HelperText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DLSAssets.icons.infoCircle.svg(
          height: 16.h,
          colorFilter: const ColorFilter.mode(
            AppColorTheme.gray500,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            text,
            style: context.appTextTheme.footnote?.copyWith(
              color: AppColorTheme.gray500,
            ),
          ),
        ),
      ],
    );
  }
}
