import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/slider_color_theme.dart';

class AppSlider extends StatefulWidget {
  const AppSlider({
    super.key,
    this.thumbIcon,
    required this.slider,
    this.theme,
    required this.trackHeight,
    this.enabledThumbRadius,
  });

  final String? thumbIcon;
  final SliderColorTheme? theme;
  final double trackHeight;
  final Slider slider;
  final double? enabledThumbRadius;

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  double intValue = 0;
  ui.Image? customImage;

  Future<ui.Image> loadImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  void initState() {
    if (widget.thumbIcon != null) {
      loadImage(widget.thumbIcon!).then((image) {
        setState(() => customImage = image);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        overlayShape: SliderComponentShape.noOverlay,
        // remove default margin in slider
        inactiveTrackColor: widget.theme?.inActiveTrackColor,
        activeTrackColor: widget.theme?.activeTrackColor,
        thumbColor: widget.theme?.thumbColor,
        trackHeight: widget.trackHeight,
        thumbShape: customImage != null
            ? SliderThumbImage(
                image: customImage!,
                theme: widget.theme,
              )
            : RoundSliderThumbShape(
                enabledThumbRadius: widget.enabledThumbRadius ?? 10),
      ),
      child: widget.slider,
    );
  }
}

class GradientSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  GradientSliderTrackShape({
    this.gradient = const LinearGradient(
      colors: [
        Colors.red,
        Colors.yellow,
      ],
    ),
    this.darkenInactive = true,
  });

  final LinearGradient gradient;
  final bool darkenInactive;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final activeGradientRect = Rect.fromLTRB(
      trackRect.left,
      (textDirection == TextDirection.ltr)
          ? trackRect.top - (additionalActiveTrackHeight / 2)
          : trackRect.top,
      thumbCenter.dx,
      (textDirection == TextDirection.ltr)
          ? trackRect.bottom + (additionalActiveTrackHeight / 2)
          : trackRect.bottom,
    );

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final activeTrackColorTween = ColorTween(
      begin: sliderTheme.disabledActiveTrackColor,
      end: sliderTheme.activeTrackColor,
    );
    final inactiveTrackColorTween = darkenInactive
        ? ColorTween(
            begin: sliderTheme.disabledInactiveTrackColor,
            end: sliderTheme.inactiveTrackColor,
          )
        : activeTrackColorTween;
    final activePaint = Paint()
      ..shader = gradient.createShader(activeGradientRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final trackRadius = Radius.circular(trackRect.height / 2);
    final activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
  }
}

class SliderThumbImage extends SliderComponentShape {
  SliderThumbImage({required this.image, this.theme});

  final ui.Image image;
  final SliderColorTheme? theme;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.zero;
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final picWidth = image.width;
    final picHeight = image.height;

    final picOffset = Offset(
      center.dx - (picWidth / 2),
      center.dy - (picHeight / 2),
    );
    final circleOffSet = ui.Offset(center.dx, center.dy);
    final paint = Paint()
      ..color = theme?.thumbIconColor ?? Colors.white
      ..filterQuality = ui.FilterQuality.high;

    final circlePaint = ui.Paint()
      ..color = (theme?.thumbColor) ?? const ui.Color(0xff000000)
      ..colorFilter;

    canvas
      ..drawCircle(circleOffSet, 20, circlePaint)
      ..drawImage(
        image,
        picOffset,
        paint,
      );
  }
}
