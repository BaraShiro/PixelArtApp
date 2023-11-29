import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelart/art_edit/art_edit.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

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
                decoration: CheckeredBackground(), // Background visible through transparent pixels
                child: pixelArtMatrix(context, art.pixelMatrix)),
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

  Widget pixelArtMatrix(BuildContext context, List<List<Pixel>> matrix) {
    return Column(
      children: matrix.mapIndexed((y, row) => pixelArtMatrixRow(context, y, row)).toList(),
    );
  }

  Widget pixelArtMatrixRow(BuildContext context, int y, List<Pixel> row){
    return Row(
      children: row.mapIndexed((x, pixel) => pixelArtMatrixCell(context, x, y, pixel)).toList(),
    );
  }

  Widget pixelArtMatrixCell(BuildContext context, int x, int y, Pixel pixel) {
    return GestureDetector(
      onSecondaryTap: () {
        Color color = Colors.white; // TODO: Get color from state somehow
        print("x: $x y: $y ${pixel.toColor()} $color");
        paintPixel(context, x, y, pixel, color);
      },
      onTap: () {
        Color color = Colors.black;
        print("x: $x y: $y ${pixel.toColor()} $color");
        paintPixel(context, x, y, pixel, color);
      },
      child: Container(
        width: 16,
        height: 16,
        color: pixel.toColor(),
      ),
    );
  }

  void paintPixel(BuildContext context, int x, int y, Pixel pixel, Color color) {
    if(pixel.toColor() == color) {
      print("Same same!");
      return;
    }

    Pixel newPixel = color.toPixel(user);
    PixelArt newArt = art.placePixel(x, y, newPixel);

    if(!newArt.editors.contains(user)) {
      print("New editor!");
      List<Participant> newEditors = List.of(newArt.editors);
      newEditors.add(user);
      newArt = newArt.copyWith(editors: newEditors);
    }

    BlocProvider.of<ArtEditBloc>(context).add(ArtEditUpdateEvent(updatedPixelArt: newArt));
  }
}