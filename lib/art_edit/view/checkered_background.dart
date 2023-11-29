import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class CheckeredBackground extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CheckeredPainter();
  }
}

class _CheckeredPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size!;
    const Pattern pattern = Checkers(bgColor: Colors.black12, fgColor: Colors.white, featuresCount: 32);

    pattern.paintOnRect(canvas, configuration.size!, bounds);
  }
}