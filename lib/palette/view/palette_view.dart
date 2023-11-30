import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelart/art_edit/art_edit.dart';
import 'package:pixelart/palette/palette.dart';

class PaletteView extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;

  const PaletteView({super.key, required this.primaryColor, required this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            children: [
              // Primary color
              Container(
                width: 32,
                height: 32,
                decoration: const CheckeredBackground(repetitions: 2),
                foregroundDecoration: BoxDecoration(
                  color: primaryColor,
                ),
              ),

              // Secondary color
              Container(
                width: 32,
                height: 32,
                decoration: const CheckeredBackground(repetitions: 2),
                foregroundDecoration: BoxDecoration(
                  color: secondaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16, height: 16),
        const Text("NES palette"),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            children: [
              for (List<Color> colors in nesPalette)
                Row(children: [
                  for (Color color in colors) paletteButton(context, color)
                ]),
            ],
          ),
        ),

      ],
    );
  }

  Widget paletteButton(BuildContext context, Color color) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PaletteBloc>(context)
            .add(UpdateColorsPaletteEvent(
              primaryColor: color,
              secondaryColor: secondaryColor
          )
        );
      },
      onSecondaryTap: () {
        BlocProvider.of<PaletteBloc>(context)
            .add(UpdateColorsPaletteEvent(
            primaryColor: primaryColor,
            secondaryColor: color
        )
        );
      },
      child: Container(
        width: 16,
        height: 16,
        // color: color,
        foregroundDecoration: BoxDecoration(
          color: color,
        ),
        decoration: const CheckeredBackground(repetitions: 1),
      ),
    );
  }

}