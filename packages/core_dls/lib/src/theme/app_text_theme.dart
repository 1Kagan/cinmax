import 'package:flutter/material.dart';

import 'package:core_dls/core_dls.dart';

part '../extensions/app_text_theme_extension.dart';

class AppTextTheme {
  AppTextTheme(this.context);

  final BuildContext context;

  TextTheme get _textTheme => Theme.of(context).textTheme;

  TextStyle? get hero => _textTheme.displayLarge
      ?.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.3,
      )
      .textStyleInterceptor(context);

  TextStyle? get h1 => _textTheme.displayLarge
      ?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        height: 1.3,
      )
      .textStyleInterceptor(context);

  TextStyle? get h2 => _textTheme.displayMedium
      ?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
      )
      .textStyleInterceptor(context);

  TextStyle? get h3 => _textTheme.displaySmall
      ?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.3,
      )
      .textStyleInterceptor(context);

  TextStyle? get body => _textTheme.bodyMedium
      ?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      )
      .textStyleInterceptor(context);

  TextStyle? get bodyEmphasis =>
      body?.copyWith(fontWeight: FontWeight.w600).textStyleInterceptor(context);

  TextStyle? get bodySmall => _textTheme.bodyMedium
      ?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: Theme.of(context).textTheme.bodyLarge!.color,
      )
      .textStyleInterceptor(context);

  TextStyle? get bodySmallEmphasis => bodySmall
      ?.copyWith(fontWeight: FontWeight.w600)
      .textStyleInterceptor(context);

  TextStyle? get xSmallRegular => _textTheme.bodySmall
      ?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
      )
      .textStyleInterceptor(context);

  TextStyle? get xxSmallRegular => _textTheme.bodySmall
      ?.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        height: 1.5,
      )
      .textStyleInterceptor(context);

  TextStyle? get xxSmallEmphasis => xxSmallRegular
      ?.copyWith(fontWeight: FontWeight.w600)
      .textStyleInterceptor(context);

  TextStyle? get xSmallEmphasis => _textTheme.bodySmall
      ?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.5,
      )
      .textStyleInterceptor(context);

  TextStyle? get footnote => _textTheme.bodySmall
      ?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
      )
      .textStyleInterceptor(context);

  TextStyle? get formPlaceholder => body
      ?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      )
      .textStyleInterceptor(context);

  TextStyle? get miniLabel => _textTheme.bodySmall
      ?.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 1.5,
      )
      .textStyleInterceptor(context);

  TextStyle? get button => _textTheme.labelLarge
      ?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      )
      .textStyleInterceptor(context);
}

extension TextStyleX on TextStyle {
  TextStyle textStyleInterceptor(context) => copyWith(
        color: Theme.of(context).textTheme.bodyLarge!.color,
        package: Constants.dlsPackageName,
      );
}
