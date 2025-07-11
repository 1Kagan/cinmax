import 'package:flutter/widgets.dart';

import '../animations/fade_animation.dart';

extension AppAnimationEx on Widget {
  Widget effectOpacity({
    required double opacity,
    Duration? duration,
  }) =>
      AnimatedOpacity(
        duration: duration ?? const Duration(milliseconds: 350),
        opacity: opacity,
        child: this,
      );

  Widget effectFadeSlideDown({double delay = 0.3}) => FadeAnimation(
        delay: delay,
        child: this,
      );
}
