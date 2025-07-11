import 'package:flutter/material.dart';
import 'package:core_dls/src/components/checkbox/app_checkbox.dart';
import 'package:core_dls/src/components/misc/list_tile_divider.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

enum CheckboxPosition {
  right,
  left,
}

class AppCheckboxListTile extends StatelessWidget {
  const AppCheckboxListTile({
    super.key,
    this.value = false,
    this.readOnly = false,
    this.onChanged,
    this.title,
    this.checkboxPosition = CheckboxPosition.right,
    this.hasTileDivider = true,
    this.checkmark,
  });

  final bool value;
  final bool readOnly;
  final bool hasTileDivider;
  final void Function(bool?)? onChanged;
  final String? title;
  final CheckboxPosition checkboxPosition;
  final Widget? checkmark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: readOnly ? null : () => onChanged?.call(!value),
      child: Column(
        children: [
          Row(
            children: [
              if (checkboxPosition == CheckboxPosition.left)
                Row(
                  children: [
                    if (checkmark != null) checkmark!,
                    AppCheckbox(
                      value: value,
                      onChanged: onChanged,
                      readOnly: readOnly,
                    ),
                  ],
                ),
              Expanded(
                child: Text(
                  title ?? '',
                  style: context.appTextTheme.bodySmall,
                ),
              ),
              if (checkboxPosition == CheckboxPosition.right)
                Row(
                  children: [
                    if (checkmark != null) checkmark!,
                    AppCheckbox(
                      value: value,
                      onChanged: onChanged,
                      readOnly: readOnly,
                    ),
                  ],
                ),
            ],
          ),
          if (hasTileDivider) const ListTileDivider(),
        ],
      ),
    );
  }
}
