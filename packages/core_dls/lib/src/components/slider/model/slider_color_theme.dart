import 'package:flutter/material.dart';
import 'package:core_dls/core_dls.dart';

class SliderColorTheme {
  final Color inActiveTrackColor, thumbIconColor, activeTrackColor, thumbColor;

  SliderColorTheme(
      {this.inActiveTrackColor = AppColorTheme.orange20,
      this.thumbIconColor = AppColorTheme.pureWhite,
      this.activeTrackColor = AppColorTheme.orange,
      this.thumbColor = AppColorTheme.darkBg});

  SliderColorTheme copyWith(
          {Color? inActiveTrackColor,
          thumbIconColor,
          activeTrackColor,
          thumbColor}) =>
      SliderColorTheme(
        activeTrackColor: activeTrackColor ?? this.activeTrackColor,
        inActiveTrackColor: inActiveTrackColor ?? this.inActiveTrackColor,
        thumbColor: thumbColor ?? this.thumbColor,
        thumbIconColor: thumbIconColor ?? this.thumbIconColor,
      );
}
