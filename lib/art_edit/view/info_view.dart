import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pixelart/art_edit/art_edit.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

class InfoView extends StatelessWidget {
  final PixelArt art;
  final Participant user;

  const InfoView({super.key, required this.art, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(art.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(art.description),
            Text("Resolution: ${art.width} x ${art.height}"),
          ],
        ),
        const SizedBox(width: 32,),
        IconButton(
          icon: const Icon(Symbols.edit),
          onPressed: () async {
            ArtEditBloc bloc = context.read<ArtEditBloc>();
            PixelArt? newArt = await showModalBottomSheet<PixelArt>(
              enableDrag: false,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(32),
                  child: EditInfoModal(art: art, user: user),
                );
              },
            );
            if(newArt != null) {
              bloc.add(ArtEditUpdateEvent(updatedPixelArt: newArt));
            }
          },
        ),
        const Spacer(),
      ],
    );
  }
}