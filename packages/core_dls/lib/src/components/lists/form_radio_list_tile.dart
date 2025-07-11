import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/components/misc/list_tile_divider.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

import '../radio_button/app_radio_button.dart';

enum RadioPosition {
  right,
  left,
}

class FormRadioListTile<T> extends StatelessWidget {
  const FormRadioListTile({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    this.title,
    this.titleStyle,
    this.outerPadding,
    this.decoration,
    this.hasTileDivider = true,
    this.radioPosition = RadioPosition.right,
  });

  final T value;
  final T groupValue;
  final void Function(T?)? onChanged;
  final RadioPosition radioPosition;
  final BoxDecoration? decoration;
  final String? title;
  final bool hasTileDivider;
  final TextStyle? titleStyle;
  final EdgeInsets? outerPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged?.call(value),
      borderRadius: decoration?.borderRadius as BorderRadius?,
      child: Container(
        padding: outerPadding,
        decoration: decoration,
        child: Column(
          children: [
            16.verticalSpace,
            Row(
              children: [
                if (radioPosition == RadioPosition.left) ...[
                  AppRadioButton<T>(
                    value: value,
                    onChanged: onChanged,
                    groupValue: groupValue,
                  ),
                  8.horizontalSpace,
                ],
                Expanded(
                  child: Text(
                    title ?? '',
                    style: titleStyle ?? context.appTextTheme.bodySmall,
                  ),
                ),
                if (radioPosition == RadioPosition.right) ...[
                  8.horizontalSpace,
                  AppRadioButton<T>(
                    value: value,
                    onChanged: onChanged,
                    groupValue: groupValue,
                  ),
                ],
              ],
            ),
            16.verticalSpace,
            if (hasTileDivider) const ListTileDivider(),
          ],
        ),
      ),
    );
  }
}
