import 'package:flutter/material.dart';
import 'package:pixelart/art_listing/art_listing.dart';

/// The primary app class, the starting point for the app.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workout',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const ArtListingPage(),
    );
  }

}