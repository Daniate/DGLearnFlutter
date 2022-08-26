import 'package:flutter/material.dart';

class DotPainter extends CustomPainter {
  final Offset _offset;

  DotPainter(this._offset);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      _offset,
      28.0,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    DotPainter oldPainter = oldDelegate as DotPainter;
    return oldPainter._offset != _offset;
  }
}
