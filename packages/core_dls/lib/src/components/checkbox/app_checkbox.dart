import 'package:flutter/material.dart';

import '../../theme/app_color_theme.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    this.value = false,
    this.readOnly = false,
    this.color = AppColorTheme.orange80,
    this.borderSideColor,
    this.onChanged,
  });

  final bool value;
  final bool readOnly;
  final Color color;
  final Color? borderSideColor;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: readOnly ? (_) {} : onChanged,
      activeColor: color.withOpacity(readOnly ? .6 : 1),
      side: BorderSide(
        color: borderSideColor ?? color.withOpacity(readOnly ? .6 : 1),
        width: 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
