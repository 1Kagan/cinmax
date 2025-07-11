import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    this.margin,
    this.onTap,
    this.height = 56,
    this.darkMode = false,
    this.isLoading = false,
    this.style,
    this.type = SecondaryButtonType.normal,
  }) : icon = null;

  const SecondaryButton.async({
    super.key,
    required this.text,
    this.margin,
    this.onTap,
    this.height = 56,
    this.darkMode = false,
    this.style,
    this.type = SecondaryButtonType.normal,
  })  : icon = null,
        isLoading = null;

  const SecondaryButton.icon({
    super.key,
    required this.text,
    required this.icon,
    this.margin,
    this.onTap,
    this.height = 56,
    this.darkMode = false,
    this.isLoading = false,
    this.style,
    this.type = SecondaryButtonType.normal,
  });

  final String text;
  final EdgeInsets? margin;
  final FutureOr<void> Function()? onTap;
  final ButtonStyle? style;
  final Widget? icon;
  final bool darkMode;
  final bool? isLoading;
  final double height;
  final SecondaryButtonType type;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  late bool internalLoading;

  @override
  void initState() {
    super.initState();
    internalLoading = widget.isLoading ?? false;
  }

  @override
  void didUpdateWidget(covariant SecondaryButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    internalLoading = widget.isLoading ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final tapAction =
        (internalLoading || widget.onTap == null) ? null : _onPressed;
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: OutlinedButton.icon(
        icon: internalLoading
            ? const SizedBox(
                width: 21,
                height: 21,
                child: CircularProgressIndicator(
                  color: AppColorTheme.darkBg,
                  strokeWidth: 3,
                ),
              )
            : widget.icon ?? const SizedBox.shrink(),
        onPressed: tapAction,
        style: (widget.style ?? OutlinedButton.styleFrom()).merge(
          OutlinedButton.styleFrom(
            minimumSize: Size.fromHeight(widget.height.h),
            side: BorderSide(
              width: 2.r,
              color: tapAction == null
                  ? AppColorTheme.passive
                  : (widget.type == SecondaryButtonType.sensitive
                      ? AppColorTheme.passive
                      : (widget.darkMode
                          ? AppColorTheme.pureWhite
                          : AppColorTheme.darkBg)),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        label: Text(
          widget.text,
          style: context.appTextTheme.button?.copyWith(
            color: tapAction == null
                ? AppColorTheme.passive
                : (widget.type == SecondaryButtonType.sensitive
                    ? AppColorTheme.passive
                    : (widget.darkMode
                        ? AppColorTheme.pureWhite
                        : AppColorTheme.darkBg)),
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

enum SecondaryButtonType {
  normal,
  sensitive,
  underline,
}
