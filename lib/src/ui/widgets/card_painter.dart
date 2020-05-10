import 'dart:math';

import 'package:flutter/material.dart';

// Custom class for giving a paint effect on the
// card items which is used to show the app's details
class CardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final centerAvatar = Offset(shapeBounds.center.dx, shapeBounds.top);
    final avatarBounds =
        Rect.fromCircle(center: centerAvatar, radius: 38).inflate(4);
    final paint = Paint()
      ..color = Color(0xFFF1F1F1)
      ..style = PaintingStyle.fill;

    final backgroundPath = Path()..arcTo(avatarBounds, 0, pi, false);
    canvas.drawPath(backgroundPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
