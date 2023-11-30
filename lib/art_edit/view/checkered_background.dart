import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class CheckeredBackground extends Decoration {
  final int repetitions;
  const CheckeredBackground({this.repetitions = 32});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CheckeredPainter(repetitions: repetitions);
  }
}

class _CheckeredPainter extends BoxPainter {
  final int repetitions;
  _CheckeredPainter({required this.repetitions});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size!;
    Pattern pattern = Checkers(bgColor: Colors.black12, fgColor: Colors.white, featuresCount: repetitions);

    pattern.paintOnRect(canvas, configuration.size!, bounds);
  }
}