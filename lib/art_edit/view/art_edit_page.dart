import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelart/art_edit/art_edit.dart';
import 'package:pixelart/palette/palette.dart';
import 'package:pixelart/loading/loading.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

class ArtEditPage extends StatelessWidget {
  final String artId;
  final Participant user;
  const ArtEditPage({super.key, required this.artId, required this.user});

  static Route<void> route({required String artId, required Participant user}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ArtEditPage(artId: artId, user: user),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin = const Offset(1.0, 0.0);
        Offset end = Offset.zero;
        Cubic curve = Curves.ease;

        Animatable<Offset> tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pixel Art Editor"),
      ),
      body: Center(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ArtEditBloc(repository: RepositoryProvider.of(context))
              ..add(ArtEditStartListeningEvent(pixelArtId: artId))),
            BlocProvider(create: (_) => PaletteBloc()),
          ],
          child: ListView(
            padding: const EdgeInsets.all(32),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Palette
                  BlocBuilder<PaletteBloc, PaletteState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, PaletteState state) {
                      return PaletteView(
                          primaryColor: state.primaryColor,
                          secondaryColor: state.secondaryColor
                      );
                    }
                  ),

                  const SizedBox(width: 32, height: 32),

                  //Edit area
                  BlocBuilder<ArtEditBloc, ArtEditState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, ArtEditState state) {
                      switch (state) {
                        case ArtEditInitial():
                          return const LoadingPage();
                        case ArtEditUpdate():
                          return ArtEditView(art: state.art, user: user);
                        case ArtEditFailure():
                          return Text("Error: ${state.error}");
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}