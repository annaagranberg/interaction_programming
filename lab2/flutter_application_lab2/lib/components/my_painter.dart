import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height + 15);

    Pattern pattern = const DiagonalStripesThick(
      bgColor: Colors.white, // Background color changed to white
      fgColor: Colors.white, // Foreground color changed to white
    );

    pattern.paintOnRect(canvas, size, rect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
