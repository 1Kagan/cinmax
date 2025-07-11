import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.size,
    required this.image,
  });

  const Avatar.large({
    super.key,
    required this.image,
  }) : size = 64;

  const Avatar.regular({
    super.key,
    required this.image,
  }) : size = 48;

  const Avatar.small({
    super.key,
    required this.image,
  }) : size = 32;

  final double size;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: image, fit: BoxFit.contain),
      ),
    );
  }
}
