import 'package:flutter/material.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';

class ListTileDivider extends StatelessWidget {
  const ListTileDivider({
    super.key,
    this.color = AppColorTheme.gray50,
    this.margin,
    this.width = 1,
  });

  final Color color;
  final double width;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: width,
          ),
        ),
      );
}
