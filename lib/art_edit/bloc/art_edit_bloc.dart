import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:pixelart_client/pixelart_client.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

part 'art_edit_event.dart';
part 'art_edit_state.dart';

class ArtEditBloc extends Bloc<ArtEditEvent, ArtEditState> {
  final HTTPPixelArtRepository repository;

  ArtEditBloc({required this.repository}) : super(ArtEditInitial()) {
    on<ArtEditStartListeningEvent>((ArtEditStartListeningEvent event, Emitter<ArtEditState> emit) async {
      await _handleArtEditStartListeningEvent(event, emit);
    },
      transformer: restartable(),
    );

    on<ArtEditUpdateEvent>((ArtEditUpdateEvent event, Emitter<ArtEditState> emit) async {
      await _handleArtEditUpdateEvent(event, emit);
    },
      transformer: restartable(), // TODO: Maybe not needed
    );
  }

  Future<void> _handleArtEditStartListeningEvent(ArtEditStartListeningEvent event, Emitter<ArtEditState> emit) async {
    // Initial read to have something to show while waiting for updates
    CRUDResult<PixelArt> readResponse = await repository.read(event.pixelArtId);
    if (readResponse.isSuccess) {
      emit(ArtEditUpdate(art: readResponse.value!));
    } // TODO: Error handling

    // Subscribe to stream and emit when receiving data
    await emit.onEach(
      await repository.changes(event.pixelArtId),
      onData: (PixelArt? art) {
        print("Got data, emitting from stream");
        emit(ArtEditUpdate(art: art!));
      },
    );
  }

  Future<void> _handleArtEditUpdateEvent(ArtEditUpdateEvent event, Emitter<ArtEditState> emit) async {
    CRUDResult<PixelArt> updateResponse = await repository.update(event.updatedPixelArt.id, event.updatedPixelArt);
    // TODO: Error handling
  }
}
