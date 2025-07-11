import 'package:flutter/material.dart';

class AbsorbPointerAndOpacity extends StatelessWidget {
  const AbsorbPointerAndOpacity({
    super.key,
    required this.child,
    required this.absorbing,
    this.opacity = .5,
  });

  final Widget child;
  final bool absorbing;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing,
      child: Opacity(
        opacity: absorbing ? opacity : 1,
        child: child,
      ),
    );
  }
}
