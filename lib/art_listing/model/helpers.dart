import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

Future<Image> pixelArtToImage({required PixelArt pixelArt}) {
  final Completer<Image> completer = Completer<Image>();
  final Uint8List pixelList = Uint8List(pixelArt.width * pixelArt.height * 4);

  for (int y = 0; y < pixelArt.height; y++) {
    for (var x = 0; x < pixelArt.width; x++) {
      int colOffset = y * pixelArt.width * 4;
      int rowOffset = x * 4;
      Pixel pixel = pixelArt.pixelMatrix[y][x];
      pixelList[colOffset + rowOffset + 0] = pixel.red.toUnsigned(8);
      pixelList[colOffset + rowOffset + 1] = pixel.green.toUnsigned(8);
      pixelList[colOffset + rowOffset + 2] = pixel.blue.toUnsigned(8);
      pixelList[colOffset + rowOffset + 3] = pixel.alpha.toUnsigned(8);
    }
  }

  // pixelList[0] = 42.toUnsigned(8);
  decodeImageFromPixels(
      pixelList,
      pixelArt.width,
      pixelArt.height,
      PixelFormat.rgba8888,
      (Image image) {
        completer.complete(image);
      },
  );

  return completer.future;
}