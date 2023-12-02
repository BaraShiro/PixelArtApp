import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelart/art_edit/art_edit.dart';
import 'package:pixelart_shared/pixelart_shared.dart';
import 'package:pixelart/palette/palette.dart';

class ArtEditView extends StatelessWidget {
  final PixelArt art;
  final Participant user;

  const ArtEditView({super.key, required this.art, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Container(
            // width and height is needed for GridView
            // width: art.width * 16,
            // height: art.height * 16,
            decoration: CheckeredBackground(repetitions: max(art.width, art.height)), // Background visible through transparent pixels
            child: pixelArtMatrix(context, art.pixelMatrix),
            // Looks better on Windows, but is slower to build
            // child: GridView.count(
            //   shrinkWrap: true,
            //   crossAxisCount: art.width,
            //   children: art.pixelMatrix.expandIndexed(
            //         (y, row) => row.mapIndexed(
            //                 (x, pixel) => pixelArtMatrixCell(context, x, y, pixel),
            //         ),
            //   ).toList(),
            // ),
          ),
        ),
        const SizedBox(width: 32, height: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text("Editors:")] + art.editors.map((e) => Text(e.name)).toList(),
        ),
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
      onTap: () {
        Color color = BlocProvider.of<PaletteBloc>(context).state.primaryColor;
        print("x: $x y: $y ${pixel.toColor()} $color");
        paintPixel(context, x, y, pixel, color);
      },
      onSecondaryTap: () {
        Color color = BlocProvider.of<PaletteBloc>(context).state.secondaryColor;
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