import 'package:flutter/material.dart';

extension WidgetX on Widget {
  Widget center() => Center(child: this);

  Widget inspect() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.redAccent,
            width: 2,
          ),
        ),
        child: this,
      );
}
