import 'package:flutter/material.dart';
import 'package:pixelart_shared/pixelart_shared.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class ArtEditView extends StatelessWidget {
  final PixelArt art;
  final Participant user;

  const ArtEditView({super.key, required this.art, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // shrinkWrap: true,
      padding: EdgeInsets.only(left: 32, top: 32, right: 32, bottom: 200),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("Palette"),
                palette(),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Container(
                decoration: CheckeredBackground(),
                child: pixelArtMatrix(art.pixelMatrix)),
            ),
            Column(
              children: art.editors.map((e) => Text(e.name)).toList(),
            ),
          ],
        ),
      ],
    );
  }

  Widget palette() {
    return Column(
      children: [
        Row(
          children: [
            Container(width: 16, height: 16, color: Color.fromARGB(255, 0, 64, 78),),
            Container(width: 16, height: 16, color: Color.fromARGB(255, 0, 124, 142),),
            Container(width: 16, height: 16, color: Color.fromARGB(255, 72, 206, 223),),
            Container(width: 16, height: 16, color: Color.fromARGB(255, 181, 236, 243),),
          ],
        ),
        Row(
          children: [
            Container(width: 16, height: 16, color: Color.fromARGB(255, 0, 79, 8),),
            Container(width: 16, height: 16, color: Color.fromARGB(255, 0, 144, 50),),
            Container(width: 16, height: 16, color: Color.fromARGB(255, 69, 225, 130),),
            Container(width: 16, height: 16, color: Color.fromARGB(255, 180, 243, 205),),
          ],
        )
      ],
    );
  }

  Widget pixelArtMatrix(List<List<Pixel>> matrix) {
    return Column(
      children: matrix.map((row) => pixelArtMatrixRow(row)).toList(),
    );
  }

  Widget pixelArtMatrixRow(List<Pixel> row){
    return Row(
      children: row.map((pixel) => pixelArtMatrixCell(pixel)).toList(),
    );
  }

  Widget pixelArtMatrixCell(Pixel pixel) {
    return Container(
      width: 16,
      height: 16,
      color: Color.fromARGB(
          pixel.alpha,
          pixel.red,
          pixel.green,
          pixel.blue),
    );
  }
}

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