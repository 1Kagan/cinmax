import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class DetailButton extends StatelessWidget {
  const DetailButton({
    super.key,
    this.label,
    this.labelTextStyle,
    this.margin,
    this.onTap,
    this.backgroundColor = AppColorTheme.darkBg,
    this.chevronRightIconEnabled = false,
    this.secondLabel,
    this.secondLabelTextStyle,
    this.isLoading = false,
    this.chevronLeftIcon,
  });

  final String? label;
  final TextStyle? labelTextStyle;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final bool chevronRightIconEnabled;
  final Widget? chevronLeftIcon;
  final bool isLoading;
  final String? secondLabel;
  final TextStyle? secondLabelTextStyle;

  @override
  Widget build(BuildContext context) {
    final firstTextStyle = (labelTextStyle ?? context.appTextTheme.button);
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Row(
              children: [
                if (chevronLeftIcon != null) ...[
                  Padding(
                    padding: EdgeInsets.only(
                      right: 18.w,
                    ),
                    child: chevronLeftIcon!,
                  ),
                ],
                Text(
                  label ?? '',
                  textAlign: TextAlign.center,
                  style: firstTextStyle,
                ),
                const Spacer(),
                if (isLoading)
                  SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(),
                  ),
                if (!isLoading) ...[
                  if (secondLabel != null) ...[
                    Text(
                      secondLabel ?? '',
                      textAlign: TextAlign.center,
                      style: (secondLabelTextStyle ??
                          context.appTextTheme.bodySmall),
                    ),
                    SizedBox(width: 4.w),
                  ],
                  if (chevronRightIconEnabled)
                    DLSAssets.icons.arrowRight.svg(
                      colorFilter: ColorFilter.mode(
                        firstTextStyle?.color ?? AppColorTheme.pureWhite,
                        BlendMode.srcIn,
                      ),
                    )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
