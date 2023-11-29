import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelart/palette/palette.dart';

class PaletteView extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;

  const PaletteView({super.key, required this.primaryColor, required this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Primary color
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: primaryColor,
                border: Border.all(color: Colors.black),
              ),
            ),

            // Secondary color
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: secondaryColor,
                border: Border.all(color: Colors.black),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16, height: 16),
        const Text("NES palette"),
        Row(
          children: [
            paletteButton(context, Color.fromARGB(255, 0, 64, 78)),
            paletteButton(context, Color.fromARGB(255, 0, 124, 142)),
            paletteButton(context, Color.fromARGB(255, 72, 206, 223)),
            paletteButton(context, Color.fromARGB(255, 181, 236, 243)),
          ],
        ),
        Row(
          children: [
            paletteButton(context, Color.fromARGB(255, 0, 79, 8)),
            paletteButton(context, Color.fromARGB(255, 0, 144, 50)),
            paletteButton(context, Color.fromARGB(255, 69, 225, 130)),
            paletteButton(context, Color.fromARGB(255, 180, 243, 205)),
          ],
        )
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
        color: color,
      ),
    );
  }

}