import 'dart:math';

import 'package:flutter/material.dart';

class ExpensiveDrawingPainter extends CustomPainter {
  static const List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.purple,
    Colors.lime,
    Colors.blueGrey,
    Colors.amber,
    Colors.lightGreen,
    Colors.pink,
  ];

  static final Random random = Random(9999);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    for (int i = 0; i < 10000; i++) {
      paint.color = colors[random.nextInt(colors.length)].withOpacity(random.nextDouble());
      Offset center = Offset(random.nextDouble() * size.width, random.nextDouble() * size.height);
      double width = random.nextDouble() * size.width / 10.0;
      double height = random.nextDouble() * size.height / 10.0;
      canvas.drawRect(Rect.fromCenter(center: center, width: width, height: height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
