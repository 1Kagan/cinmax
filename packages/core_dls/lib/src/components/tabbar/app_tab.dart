import 'package:flutter/material.dart';

class AppTab extends StatelessWidget implements PreferredSizeWidget {
  const AppTab(
      {super.key,
      this.text,
      this.child,
      this.icon,
      this.isDone,
      this.iconMargin,
      this.height});
  final String? text;

  final Widget? child;

  final Widget? icon;

  final bool? isDone;

  final EdgeInsetsGeometry? iconMargin;

  final double? height;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final double calculatedHeight;
    final Widget label;
    if (icon == null) {
      calculatedHeight = 46;
      label = _buildLabelText();
    } else if (text == null && child == null) {
      calculatedHeight = 46;
      label = icon!;
    } else {
      calculatedHeight = 72;
      label = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildLabelText(),
          Container(
            margin: iconMargin,
            child: icon,
          ),
        ],
      );
    }

    return SizedBox(
      height: height ?? calculatedHeight,
      child: Center(
        widthFactor: 1.0,
        child: label,
      ),
    );
  }

  Widget _buildLabelText() {
    return child ?? Text(text!, softWrap: false, overflow: TextOverflow.fade);
  }

  @override
  Size get preferredSize {
    if (height != null) {
      return Size.fromHeight(height!);
    } else if ((text != null || child != null) && icon != null) {
      return const Size.fromHeight(72);
    } else {
      return const Size.fromHeight(46);
    }
  }
}
