import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class MainNodeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainNodeAppBar({
    super.key,
    this.additionalWidget,
    this.images,
    // this.appBarColor,
  });

  final List<Widget>? images;
  // final Color? appBarColor;
  final Widget? additionalWidget;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Theme.of(context).brightness,
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          height: height,
          // color: appBarColor ?? AppColorTheme.pureWhite,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox.shrink(),
                ),
              ),
              // Centered logo images
              if (images != null)
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: images!,
                  ),
                ),
              // Additional widget aligned to the end
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: additionalWidget ?? const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  static double height = 72.h;
}
