import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pixelart/art_edit/art_edit.dart';
import 'package:pixelart/art_listing/art_listing.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

class ArtListingCardWidget extends StatelessWidget {
  final PixelArt pixelArt;

  const ArtListingCardWidget({super.key, required this.pixelArt});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ListTile(
        isThreeLine: true,
        titleAlignment: ListTileTitleAlignment.center,
        leading: SizedBox(
          height: double.maxFinite,
          child: FittedBox(
              child: PixelArtIcon(pixelArt: pixelArt),
          ),
        ),
        title: Text(pixelArt.name),
        subtitle: Text(pixelArt.description),
        trailing: TextButton.icon(
          onPressed: () => Navigator.push(context, ArtEditPage.route(artId: pixelArt.id, user: anon)), // TODO: Supply current user
          label: const Text("Edit"),
          icon: const Icon(Symbols.palette),
        ),
      ),
    );
  }
}

