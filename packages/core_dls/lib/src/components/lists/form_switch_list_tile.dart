import 'package:core_dls/src/components/misc/list_tile_divider.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormSwitchListTile extends StatelessWidget {
  const FormSwitchListTile({
    super.key,
    this.value = false,
    this.onChanged,
    this.title,
    this.color,
    this.showDivider = true,
    this.dividerColor,
    this.textStyle,
    this.scale,
    this.verticalPadding,
  });

  final bool value;
  final void Function(bool?)? onChanged;
  final String? title;
  final Color? color;
  final bool showDivider;
  final Color? dividerColor;
  final TextStyle? textStyle;
  final double? scale;
  final double? verticalPadding; // Yeni verticalPadding parametresi

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged?.call(value),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title ?? '',
                  style: textStyle ??
                      context.appTextTheme.bodySmall?.copyWith(
                        fontSize: 13.sp,
                      ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: verticalPadding ?? 12.h),
                child: scale != null
                    ? Transform.scale(
                        scale: scale!,
                        child: CupertinoSwitch(
                          value: value,
                          activeColor: color ?? AppColorTheme.orange80,
                          onChanged: onChanged,
                        ),
                      )
                    : CupertinoSwitch(
                        value: value,
                        activeColor: color ?? AppColorTheme.orange80,
                        onChanged: onChanged,
                      ),
              ),
            ],
          ),
          Visibility(
            visible: showDivider,
            child: ListTileDivider(
              color: dividerColor ?? AppColorTheme.gray50,
            ),
          ),
        ],
      ),
    );
  }
}
