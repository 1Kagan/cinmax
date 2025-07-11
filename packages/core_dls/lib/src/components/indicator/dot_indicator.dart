import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_color_theme.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.pageLength,
    required this.activeIndex,
    this.activeColor,
    this.borderColor,
    this.radius,
    this.borderWidth,
    this.indicatorSpace,
  });

  final int pageLength;
  final int activeIndex;
  final num? radius;
  final Color? activeColor, borderColor;
  final double? borderWidth, indicatorSpace;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: pageLength > 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          pageLength,
          (index) => AnimatedContainer(
            margin: EdgeInsets.all(
                (indicatorSpace != null ? indicatorSpace! / 2 : null) ?? 4.r),
            duration: const Duration(milliseconds: 350),
            height: (radius ?? 16).r,
            width: (radius ?? 16).r,
            decoration: BoxDecoration(
              color: activeIndex == index
                  ? activeColor ?? AppColorTheme.orange
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                width: borderWidth ?? 2.r,
                color: borderColor ?? AppColorTheme.pureWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
