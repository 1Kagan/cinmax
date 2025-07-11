import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/components/button/secondary_button.dart';
import 'package:core_dls/src/components/feedbacks/bottom_sheet/widgets/app_bottom_sheet.dart';
import 'package:core_dls/src/components/feedbacks/bottom_sheet/widgets/close_icon.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet.positive({
    super.key,
    this.level = BottomSheetType.positive,
    required this.buttonLabel,
    this.onButtonTap,
    this.onCloseButtonTap,
    this.subtitle,
    required this.title,
    this.onSecondButtonTap,
    this.secondButtonLabel,
    this.secondaryButtonType = SecondaryButtonType.normal,
    this.darkMode,
  })  : textFieldHint = null,
        onTextFieldChange = null,
        headerIcon = null,
        titleColor = null,
        textInputFormatters = null;

  const AppBottomSheet.informative({
    super.key,
    this.level = BottomSheetType.informative,
    required this.buttonLabel,
    this.onButtonTap,
    this.onCloseButtonTap,
    this.subtitle,
    this.textFieldHint,
    this.onTextFieldChange,
    this.textInputFormatters,
    required this.title,
    this.onSecondButtonTap,
    this.secondButtonLabel,
    this.secondaryButtonType = SecondaryButtonType.normal,
    this.darkMode,
  })  : headerIcon = null,
        titleColor = null;

  const AppBottomSheet.negative({
    super.key,
    this.level = BottomSheetType.negative,
    required this.buttonLabel,
    this.onButtonTap,
    this.onCloseButtonTap,
    this.subtitle,
    required this.title,
    this.onSecondButtonTap,
    this.secondButtonLabel,
    this.secondaryButtonType = SecondaryButtonType.normal,
    this.darkMode,
  })  : textFieldHint = null,
        onTextFieldChange = null,
        headerIcon = null,
        titleColor = null,
        textInputFormatters = null;

  const AppBottomSheet.custom({
    super.key,
    this.level = BottomSheetType.custom,
    required this.buttonLabel,
    this.onButtonTap,
    this.onCloseButtonTap,
    this.subtitle,
    this.textFieldHint,
    this.onTextFieldChange,
    this.textInputFormatters,
    required this.title,
    this.onSecondButtonTap,
    this.secondButtonLabel,
    required this.secondaryButtonType,
    required this.headerIcon,
    this.titleColor,
    this.darkMode,
  });

  final BottomSheetType level;
  final String title;
  final dynamic subtitle;
  final String? buttonLabel;
  final String? textFieldHint;
  final void Function(String)? onTextFieldChange;
  final List<TextInputFormatter>? textInputFormatters;
  final VoidCallback? onButtonTap;
  final VoidCallback? onCloseButtonTap;
  final SecondaryButtonType secondaryButtonType;
  final String? secondButtonLabel;
  final void Function()? onSecondButtonTap;
  final Widget? headerIcon;
  final Color? titleColor;
  final bool? darkMode;

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

enum BottomSheetType { informative, positive, negative, custom }

class _AppBottomSheetState extends State<AppBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(24.r),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.onCloseButtonTap != null)
              CloseIcon(onTap: widget.onCloseButtonTap!),
            widget.headerIcon ?? _headerIcon(),
            AppBottomSheetBody(
              title: widget.title,
              buttonLabel: widget.buttonLabel,
              onButtonTap: widget.onButtonTap,
              subTitle: widget.subtitle,
              titleColor: widget.titleColor ?? _titleColor(),
              textFieldHint: widget.textFieldHint,
              textInputFormatters: widget.textInputFormatters,
              onTextFieldChange: widget.onTextFieldChange,
              onSecondButtonTap: widget.onSecondButtonTap,
              secondButtonLabel: widget.secondButtonLabel,
              secondaryButtonType: widget.secondaryButtonType,
              darkMode: widget.darkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerIcon() {
    return Column(
      children: [
        if (widget.level == BottomSheetType.informative)
          DLSAssets.icons.infoCircle.svg(
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onBackground,
              BlendMode.srcIn,
            ),
          ),
        if (widget.level == BottomSheetType.negative)
          DLSAssets.icons.addCircle.svg(
            colorFilter: const ColorFilter.mode(
              AppColorTheme.negative,
              BlendMode.srcIn,
            ),
          ),
        if (widget.level == BottomSheetType.positive)
          DLSAssets.icons.tickCircle.svg(
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onBackground,
              BlendMode.srcIn,
            ),
          ),
      ],
    );
  }

  Color? _titleColor() {
    switch (widget.level) {
      case BottomSheetType.positive:
        return AppColorTheme.positive;
      case BottomSheetType.negative:
        return AppColorTheme.negative;
      default:
        return null;
    }
  }
}
