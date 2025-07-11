import 'package:flutter/material.dart';
import 'package:core_dls/core_dls.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:async';

class CustomActionButton extends StatefulWidget {
  const CustomActionButton({
    super.key,
    required this.text,
    this.margin,
    this.onTap,
    this.height = 50,
    this.darkMode = false,
    this.isLoading = false,
    this.style,
    this.textStyle,
    this.borderRadius = 40,
    this.width,
  });

  const CustomActionButton.async({
    super.key,
    required this.text,
    this.margin,
    this.onTap,
    this.height = 56,
    this.darkMode = false,
    this.style,
    this.textStyle,
    this.borderRadius = 40,
    this.width,
  }) : isLoading = null;

  final String text;
  final EdgeInsets? margin;
  final FutureOr<void> Function()? onTap;
  final ButtonStyle? style;
  final bool? isLoading;
  final bool darkMode;
  final double height;
  final TextStyle? textStyle;
  final double borderRadius;
  final double? width;

  @override
  State<CustomActionButton> createState() => _CustomActionButtonState();
}

class _CustomActionButtonState extends State<CustomActionButton> {
  late bool internalLoading;

  @override
  void initState() {
    super.initState();
    internalLoading = widget.isLoading ?? false;
  }

  @override
  void didUpdateWidget(covariant CustomActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    internalLoading = widget.isLoading ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final tapAction =
        (internalLoading || widget.onTap == null) ? null : _onPressed;
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: ElevatedButton.icon(
        icon: internalLoading
            ? const SizedBox(
                width: 21,
                height: 21,
                child: CircularProgressIndicator(
                  color: AppColorTheme.pureWhite,
                  strokeWidth: 3,
                ),
              )
            : const SizedBox.shrink(),
        onPressed: tapAction,
        style: (widget.style ?? ElevatedButton.styleFrom()).merge(
          ElevatedButton.styleFrom(

            minimumSize: Size.fromWidth(widget.width != null ? widget.width!.w : double.infinity),
            backgroundColor: tapAction == null
                ? AppColorTheme.passive
                : (widget.darkMode
                    ? AppColorTheme.pureWhite
                    : AppColorTheme.orange),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
            ),
          ),
        ),
        label: Text(
          widget.text,
          style: (widget.textStyle ?? context.appTextTheme.button)?.merge(
            TextStyle(
              color: tapAction == null
                  ? AppColorTheme.darkBg
                  : (widget.darkMode
                      ? AppColorTheme.darkBg
                      : AppColorTheme.pureWhite),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    setState(() => internalLoading = true);
    try {
      await widget.onTap?.call();
    } finally {
      setState(() => internalLoading = false);
    }
  }
}
