import 'package:flutter/material.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class UnderlinedTextButton extends StatelessWidget {
  const UnderlinedTextButton({
    required this.text,
    super.key,
    this.textStyle,
    this.onPressed,
  });

  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: (textStyle ?? context.appTextTheme.bodyEmphasis)?.copyWith(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
