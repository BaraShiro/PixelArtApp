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
      // color: Theme.of(context).colorScheme.surfaceVariant,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ListTile(
        isThreeLine: true,
        titleAlignment: ListTileTitleAlignment.center,
        leading: SizedBox(
          // width: 42,
          height: double.maxFinite,
          child: FittedBox(
              child: PixelArtIcon(pixelArt: pixelArt)
          ),
        ),//Icon(
        //   Symbols.art_track,
        //   // color: Theme.of(context).colorScheme.onSurfaceVariant,
        //   size: 48,
        // ),
        title: Text(pixelArt.name),
        subtitle: Text(pixelArt.description),
        trailing: TextButton.icon(
          // color: Colors.green,//Theme.of(context).colorScheme.primary,
          // hoverColor: Colors.greenAccent,//Theme.of(context).colorScheme.inversePrimary,
          // style: ButtonStyle(
          //
          // ),
          onPressed: () => {}, //context
              // .read<DashboardBloc>()
              // .add(DeleteSessionEvent(uuid: workout.uuid)),
          label: Text("Edit"),
          icon: Icon(
            Symbols.palette,
          ),
        ),
      ),
    );
  }
}

