import 'package:flutter/material.dart';
import 'package:pixelart/art_listing/art_listing.dart';
import 'package:pixelart_shared/pixelart_shared.dart';
import 'dart:ui' as ui;

class PixelArtIcon extends StatelessWidget {
  final PixelArt pixelArt;

  const PixelArtIcon({super.key, required this.pixelArt});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
        future: pixelArtToImage(pixelArt: pixelArt),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomPaint(
              // Passing our image
              painter: _ImagePainter(image: snapshot.data!),
              child: Container(
                width: pixelArt.width.toDouble(),
                height: pixelArt.height.toDouble(),
              ),
            );
          }
          return Text("Error!");
        }
    );
  }

}

/// Paints given [ui.Image] on [ui.Canvas]
/// does not repaint
class _ImagePainter extends CustomPainter {
  ui.Image image;

  _ImagePainter({required this.image});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}