import 'package:flutter/material.dart';

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
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: primaryColor,
                border: Border.all(color: Colors.black),
              ),
            ),
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
        Text("Palette"),
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

}