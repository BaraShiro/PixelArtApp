import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pixelart/art_edit/art_edit.dart';
import 'package:pixelart/art_listing/art_listing.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

class ArtListingCardWidget extends StatelessWidget {
  final PixelArt pixelArt;
  final Participant user;

  const ArtListingCardWidget({super.key, required this.pixelArt, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            TextButton.icon(
              onPressed: () => Navigator.push(context, ArtEditPage.route(artId: pixelArt.id, user: user))
                  .whenComplete(() => BlocProvider.of<ArtListingBloc>(context).add(ListAllArtEvent(user: user))),
              label: const Text("Edit"),
              icon: const Icon(Symbols.palette),
            ),

            const SizedBox(width: 16,),

            SizedBox( // For that retro pixel art look
              width: pixelArt.width * 2,
              height: pixelArt.height * 2,
              child: FittedBox(
                child: PixelArtIcon(pixelArt: pixelArt),
              ),
            ),

            const SizedBox(width: 16,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pixelArt.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(pixelArt.description),
                Text("Resolution: ${pixelArt.width} x ${pixelArt.height}"),
              ],
            ),

            const Spacer(),

            TextButton.icon(
              onPressed: () => BlocProvider.of<ArtListingBloc>(context)
                  .add(DeleteArtEvent(id: pixelArt.id, user: user)),
              label: Text("Delete",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              icon: Icon(Symbols.delete_forever,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],

        ),
      ),
      // child: ListTile(
      //   isThreeLine: true,
      //   titleAlignment: ListTileTitleAlignment.center,
      //   leading: SizedBox(
      //     height: double.maxFinite,
      //     child: FittedBox(
      //         child: PixelArtIcon(pixelArt: pixelArt),
      //     ),
      //   ),
      //   title: Text(pixelArt.name),
      //   subtitle: Text(pixelArt.description),
      //   trailing: TextButton.icon(
      //     onPressed: () => Navigator.push(context, ArtEditPage.route(artId: pixelArt.id, user: user))
      //         .whenComplete(() => BlocProvider.of<ArtListingBloc>(context).add(ListAllArtEvent(user: user))),
      //     label: const Text("Edit"),
      //     icon: const Icon(Symbols.palette),
      //   ),
      // ),
    );
  }
}

