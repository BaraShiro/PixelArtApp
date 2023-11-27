import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelart/art_listing/art_listing.dart';
import 'package:pixelart_client/pixelart_client.dart';

/// The primary app class, the starting point for the app.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<HTTPPixelArtRepository>(
      create: (BuildContext context) => const HTTPPixelArtRepository(url: "localhost:8080/pixelart"),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pixel art edit',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        home: const ArtListingPage(),
      ),
    );
  }
}