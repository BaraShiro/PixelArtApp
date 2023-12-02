import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelart/art_listing/art_listing.dart';
import 'package:pixelart/loading/loading.dart';

class ArtListingPage extends StatelessWidget {
  const ArtListingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ArtListingPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pixel Art"),
      ),
      body: Center(
        child: BlocProvider(
          create: (_) => ArtListingBloc(
              repository: RepositoryProvider.of(context)
          )..add(const ListAllArtEvent(user: anon),
            ),
          child: BlocBuilder<ArtListingBloc, ArtListingState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, ArtListingState state) {
              switch (state) {
                case ArtListingInitial():
                  return const LoadingPage();
                case ArtListingInProgress():
                  return const LoadingPage();
                case ArtListingSuccess():
                  return ArtListingView(pixelArtList: state.artList, user: state.user);
                case ArtListingFailure():
                  return Text("Error: ${state.error}"); // TODO: Add reload button so user is preserved
              }
            },
          ),
        ),
      ),
    );
  }


}