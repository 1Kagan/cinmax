import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/assets.gen.dart';
import '../../theme/app_color_theme.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});
  
  final GestureTapCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.pop(context),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColorTheme.pureWhite,
        ),
        padding: EdgeInsets.all(12.r),
        child: DLSAssets.icons.arrowLeft.svg(
          colorFilter: const ColorFilter.mode(
            AppColorTheme.pureBlack,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
