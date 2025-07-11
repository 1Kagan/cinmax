import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/components/feedbacks/toasts/widgets/toast_body.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';

enum ToastType { informative, positive, negative }

class Toasts extends StatelessWidget {
  const Toasts.positive({
    super.key,
    this.status = ToastType.positive,
    required this.title,
  });

  const Toasts.informative({
    super.key,
    this.status = ToastType.informative,
    required this.title,
  });

  const Toasts.negative({
    super.key,
    this.status = ToastType.negative,
    required this.title,
  });

  final ToastType status;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ToastBody(
      title: title,
      backGroundColor: _backgroundColor(),
      headerIcon: _headerIcon(),
      borderColor: _borderColor()!,
    );
  }

  Color? _backgroundColor() {
    switch (status) {
      case ToastType.positive:
        return AppColorTheme.positiveLight;
      case ToastType.negative:
        return AppColorTheme.negativeLight;
      default:
        return AppColorTheme.pureWhite;
    }
  }

  Color? _borderColor() {
    switch (status) {
      case ToastType.positive:
        return AppColorTheme.positive;
      case ToastType.negative:
        return AppColorTheme.negative;
      default:
        return AppColorTheme.pureBlack;
    }
  }

  Widget _headerIcon() {
    switch (status) {
      case ToastType.informative:
        return DLSAssets.icons.warning2.svg(
          height: 20.h,
          width: 20.w,
        );
      case ToastType.negative:
        return DLSAssets.icons.forbidden.svg(
          height: 20.h,
          width: 20.w,
        );
      case ToastType.positive:
        return DLSAssets.icons.tickSquare.svg(
          height: 20.h,
          width: 20.w,
        );
    }
  }
}
