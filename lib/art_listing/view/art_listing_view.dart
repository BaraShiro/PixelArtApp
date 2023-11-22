import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pixelart/art_listing/art_listing.dart';
import 'package:pixelart_client/pixelart_client.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

class ArtListingView extends StatelessWidget {
  final List<PixelArt> pixelArtList;

  const ArtListingView({super.key, required this.pixelArtList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: switch (pixelArtList.isEmpty) {
          true => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No art found!'),
                  Text('Add a new artwork and start creating!')
                ],
              )),
          false => ListView.builder(
              padding: const EdgeInsets.only(bottom: 200, top: 10),
              itemCount: pixelArtList.length,
              itemBuilder: (
                  BuildContext context,
                  int index,
                  ) {
                return ArtListingCardWidget(pixelArt: pixelArtList[index]);
              }),
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      //   foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      //   onPressed: () =>
      //       Navigator.push(context, AddSessionPage.route()).whenComplete(
      //             () => context.read<DashboardBloc>().add(GetAllSessionsEvent()),
      //       ),
      //   label: const Text("New workout session"),
      //   icon: const Icon(Symbols.add),
      // ),
    );
  }

  // Widget workoutSessionWidget(Workout workout, BuildContext context) {
  //   return Center(
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 5, right: 5),
  //       child: DashboardCardWidget(
  //         workout: workout,
  //       ),
  //     ),
  //   );
  // }
}