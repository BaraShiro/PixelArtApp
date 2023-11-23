import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelart_client/pixelart_client.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

part 'art_listing_event.dart';
part 'art_listing_state.dart';

class ArtListingBloc extends Bloc<ArtListingEvent, ArtListingState> {
  final HTTPPixelArtRepository repository;
  ArtListingBloc({required this.repository}) : super(ArtListingInitial()) {
    on<ArtListingEvent>((ArtListingEvent event, Emitter<ArtListingState> emit) async {
      switch (event) {
        case ListAllArtEvent():
          await _handleListAllArtEvent(event, emit);
      }
    });
  }

  Future<void> _handleListAllArtEvent(ListAllArtEvent event, Emitter<ArtListingState> emit) async {
    emit(ListAllArtInProgress());
    CRUDResult<List<PixelArt>> response = await repository.list();

    if(response.isSuccess) {
      print("Success");
      emit(ListAllArtSuccess(artList: response.value!));
    } else {
      print("Failure");
      print("${response.status}");
      print("${response.error}");
      emit(ListAllArtFailure(error: response.error));
    }
  }

  // void
}
