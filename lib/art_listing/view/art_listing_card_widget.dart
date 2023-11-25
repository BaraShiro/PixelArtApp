import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pixelart/art_listing/art_listing.dart';
import 'package:pixelart_client/pixelart_client.dart';
import 'package:pixelart_shared/pixelart_shared.dart';
import 'dart:ui' as ui;

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
          onPressed: () => {},//context
              // .read<ArtListingBloc>()
              // .add(DeleteArtEvent(id: pixelArt.id)),
          label: const Text("Edit"),
          icon: const Icon(Symbols.palette),
        ),
      ),
    );
  }
}

