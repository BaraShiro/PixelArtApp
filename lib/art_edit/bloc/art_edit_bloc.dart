import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixelart_client/pixelart_client.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

part 'art_edit_event.dart';
part 'art_edit_state.dart';

class ArtEditBloc extends Bloc<ArtEditEvent, ArtEditState> {
  final HTTPPixelArtRepository repository;

  ArtEditBloc({required this.repository}) : super(ArtEditInitial()) {
    on<ArtEditEvent>((ArtEditEvent event, Emitter<ArtEditState> emit) async {
      switch (event) {
        case ArtEditStartListeningEvent():
          await _handleArtEditStartListeningEvent(event, emit);
        case ArtEditUpdateEvent():
          await _handleArtEditUpdateEvent(event, emit);
      }
    });
  }

  Future<void> _handleArtEditUpdateEvent(ArtEditUpdateEvent event, Emitter<ArtEditState> emit) async {

  }

  Future<void> _handleArtEditStartListeningEvent(ArtEditStartListeningEvent event, Emitter<ArtEditState> emit) async {
    CRUDResult<PixelArt> readResponse = await repository.read(event.pixelArtId);
    if (readResponse.isSuccess) {
      emit(ArtEditUpdate(art: readResponse.value!));
    }
  }
}
