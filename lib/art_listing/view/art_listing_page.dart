import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pixelart/art_listing/art_listing.dart';
import 'package:pixelart_client/pixelart_client.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

class ArtListingPage extends StatelessWidget {
  const ArtListingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ArtListingPage());
  }

  final _redPixel = const Pixel(
    red: 255,
    green: 0,
    blue: 0,
    alpha: 255,
    placedBy: Participant(id: '1', name: 'John Doe'),
  );

  final _bluePixel = const Pixel(
    red: 0,
    green: 0,
    blue: 255,
    alpha: 255,
    placedBy: Participant(id: '2', name: 'Jane Smith'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pixel Art"),
      ),
      body: Center(
        child: BlocProvider(
          create: (_) => ArtListingBloc(),
          child: BlocBuilder<ArtListingBloc, ArtListingState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, ArtListingState state) {
              switch (state) {

                case ArtListingInitial():
                  return ArtListingView(
                    pixelArtList: [
                      PixelArt(
                          id: "id",
                          name: "name",
                          description: "description",
                          width: 4,
                          height: 4,
                          editors: [],
                          pixelMatrix: [
                            [_bluePixel, _bluePixel, _bluePixel, _bluePixel],
                            [_redPixel, _redPixel, _redPixel, _redPixel],
                            [_bluePixel, _bluePixel, _bluePixel, _bluePixel],
                            [_redPixel, _redPixel, _redPixel, _redPixel],
                          ]
                      )
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }


}