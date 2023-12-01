import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:pixelart_shared/pixelart_shared.dart';
import 'package:uuid/uuid.dart';

Future<Image> pixelArtToImage({required PixelArt pixelArt}) async {
  final Completer<Image> completer = Completer<Image>();
  final Uint8List pixelList = Uint8List(pixelArt.width * pixelArt.height * 4);
  const Pixel debug = Pixel(
      red: 255,
      green: 0,
      blue: 255,
      alpha: 255,
      placedBy: Participant(id: "debug", name: "debug"));

  for (int y = 0; y < pixelArt.height; y++) {
    for (var x = 0; x < pixelArt.width; x++) {
      int colOffset = y * pixelArt.width * 4;
      int rowOffset = x * 4;
      Pixel pixel;
      if (y >= pixelArt.pixelMatrix.length ||
          x >= pixelArt.pixelMatrix[y].length) {
        pixel = debug;
      } else {
        pixel = pixelArt.pixelMatrix[y][x];
      }

      pixelList[colOffset + rowOffset + 0] = pixel.red.toUnsigned(8);
      pixelList[colOffset + rowOffset + 1] = pixel.green.toUnsigned(8);
      pixelList[colOffset + rowOffset + 2] = pixel.blue.toUnsigned(8);
      pixelList[colOffset + rowOffset + 3] = pixel.alpha.toUnsigned(8);
    }
  }

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

const Participant anon = Participant(id: 'anonymous', name: 'Anonymous');

Participant constructNewUser({required String userName}) {
  return Participant(id: const Uuid().v4(), name: userName);
}

PixelArt constructNewPixelArt(
    {required Participant creator,
    required String name,
    required String description,
    required int width,
    required int height}) {
  int validateDimension(int dimension) => dimension < 16
      ? 16
      : dimension > 128
          ? 128
          : dimension;

  Pixel background = Pixel(
    red: 255,
    green: 255,
    blue: 255,
    alpha: 0,
    placedBy: creator,
  );

  return PixelArt(
      id: const Uuid().v4(),
      name: name,
      description: description,
      width: validateDimension(width),
      height: validateDimension(height),
      editors: [creator],
      pixelMatrix: List<List<Pixel>>.filled(
          height, List<Pixel>.filled(width, background),
      ),
  );
}
