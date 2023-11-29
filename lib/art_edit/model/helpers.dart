import 'dart:ui';

import 'package:pixelart_shared/pixelart_shared.dart';

extension ColorConvert on Color {
  Pixel toPixel(Participant user) {
    return Pixel(
      red: red,
      green: green,
      blue: blue,
      alpha: alpha,
      placedBy: user,
    );
  }
}

extension PixelConvert on Pixel {
  Color toColor() {
    return Color.fromARGB(alpha, red, green, blue);
  }
}