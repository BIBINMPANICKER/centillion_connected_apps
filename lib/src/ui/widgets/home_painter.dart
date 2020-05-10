import 'package:flutter/material.dart';

// custom paint  class to given the designs on the UI's
class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFF1F1F1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.0
      ..style = PaintingStyle.fill;

    Path path = Path();

    // painting the bottom of the screens
    path.moveTo(size.width * .49, size.height);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.935,
        size.width * 0.71, size.height * 0.91);
    path.quadraticBezierTo(
        size.width * 0.87, size.height * 0.86, size.width, size.height * 0.75);
    path.lineTo(size.width, size.height);

    // painting the top of the screens
    path.addArc(Rect.fromLTWH(0, 0, size.width, size.height * .5),
        degToRad(180), degToRad(90));
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  num degToRad(num deg) => deg * (3.14 / 180.0);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
