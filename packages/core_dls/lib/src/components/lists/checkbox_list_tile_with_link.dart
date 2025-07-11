import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:core_dls/core_dls.dart';

enum CheckboxListTilePosition {
  right,
  left,
}

enum CheckboxListTileVerticalPosition {
  top,
  center,
  bottom,
}

class AppCheckboxListTileWithLink extends StatelessWidget {
  const AppCheckboxListTileWithLink({
    super.key,
    this.value = false,
    this.onChanged,
    this.title,
    this.checkboxPosition = CheckboxListTilePosition.right,
    this.checkboxVerticalPosition = CheckboxListTileVerticalPosition.center,
    this.hasTileDivider = true,
    this.onTap,
    this.linkTextDecoration = TextDecoration.none,
  });

  final bool value;
  final bool hasTileDivider;
  final void Function(bool?)? onChanged;
  final String? title;
  final CheckboxListTilePosition checkboxPosition;
  final CheckboxListTileVerticalPosition checkboxVerticalPosition;
  final void Function(String?, Map<String?, String?>)? onTap;
  final TextDecoration linkTextDecoration;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged?.call(value),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: checkboxVerticalPosition ==
                    CheckboxListTileVerticalPosition.center
                ? CrossAxisAlignment.center
                : checkboxVerticalPosition ==
                        CheckboxListTileVerticalPosition.bottom
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            children: [
              if (checkboxPosition == CheckboxListTilePosition.left)
                AppCheckbox(
                  value: value,
                  onChanged: onChanged,
                ),
              Expanded(
                child: StyledText(
                  text: title!,
                  style: context.appTextTheme.bodySmall,
                  tags: {
                    'link': StyledTextActionTag(
                      onTap!,
                      style: context.appTextTheme.bodySmallEmphasis!
                          .copyWith(decoration: linkTextDecoration),
                    ),
                  },
                ),
              ),
              if (checkboxPosition == CheckboxListTilePosition.right)
                AppCheckbox(
                  value: value,
                  onChanged: onChanged,
                ),
            ],
          ),
          if (hasTileDivider) const ListTileDivider(),
        ],
      ),
    );
  }
}
