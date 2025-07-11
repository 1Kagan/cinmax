import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({
    super.key,
    required this.delay,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
// Simple staggered tween
    final tween2 = MovieTween()
      ..scene(
              begin: const Duration(milliseconds: 0),
              duration: const Duration(milliseconds: 500))
          .tween(AniProps.opacity, Tween<double>(begin: 0.0, end: 1.0))
      ..scene(
        begin: const Duration(milliseconds: 0),
        end: const Duration(milliseconds: 500),
      ).tween(
        AniProps.translateY,
        Tween<double>(begin: -30.0, end: 0.0),
        curve: Curves.easeOut,
      );

    // ignore: deprecated_member_use
    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween2.duration,
      tween: tween2,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(0, value.get(AniProps.translateY)), child: child),
      ),
    );
  }
}
