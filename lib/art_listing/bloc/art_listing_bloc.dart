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
        case DeleteArtEvent():
          await _handleDeleteArtEvent(event, emit);
        case AddArtEvent():
          await _handleAddArtEvent(event, emit);
        case UpdateUserEvent():
          _handleUpdateUserEvent(event, emit);
      }
    });
  }

  Future<void> _handleListAllArtEvent(ListAllArtEvent event, Emitter<ArtListingState> emit) async {
    emit(ListAllArtInProgress());
    CRUDResult<List<PixelArt>> response = await repository.list();

    if(response.isSuccess) {
      print("Success");
      if(response.value != null) {
        emit(ListAllArtSuccess(artList: response.value!, user: event.user));
      } else {
        print("Value null");
        emit(ListAllArtFailure(error: "Response was success but value was null", user: event.user));
      }

    } else {
      print("Failure");
      print("${response.status}");
      print("${response.error}");
      emit(ListAllArtFailure(error: response.error, user: event.user));
    }
  }

  Future<void> _handleDeleteArtEvent(DeleteArtEvent event, Emitter<ArtListingState> emit) async {
    emit(DeleteArtInProgress());
    CRUDResult<void> deleteResponse = await repository.delete(event.id);

    if(deleteResponse.isSuccess) {
      print("Delete success");
      CRUDResult<List<PixelArt>> listResponse = await repository.list();
      if(listResponse.isSuccess) {
        if(listResponse.value != null) {
          print("List success");
          emit(DeleteArtSuccess(artList: listResponse.value!, user: event.user));
        } else {
          print("List value null");
          emit(DeleteArtFailure(error: "Response was success but value was null", user: event.user));
        }
      } else {
        print("List failure");
        print("${listResponse.status}");
        print("${listResponse.error}");
        emit(DeleteArtFailure(error: listResponse.error, user: event.user));
      }
    } else {
      print("Delete failure");
      print("${deleteResponse.status}");
      print("${deleteResponse.error}");
      emit(DeleteArtFailure(error: deleteResponse.error, user: event.user));
    }
  }

  Future<void> _handleAddArtEvent(AddArtEvent event, Emitter<ArtListingState> emit) async {
    emit(AddArtInProgress());

    CRUDResult<PixelArt> createResponse = await repository.create(event.newArt);

    if(createResponse.isSuccess) {
      print("Create success");
      CRUDResult<List<PixelArt>> listResponse = await repository.list();
      if(listResponse.isSuccess) {
        if(listResponse.value != null) {
          print("List success");
          emit(AddArtSuccess(artList: listResponse.value!, user: event.user));
        } else {
          print("List value null");
          emit(AddArtFailure(error: "Response was success but value was null", user: event.user));
        }
      } else {
        print("List failure");
        print("${listResponse.status}");
        print("${listResponse.error}");
        emit(AddArtFailure(error: listResponse.error, user: event.user));
      }
    } else {
      print("Create failure");
      print("${createResponse.status}");
      print("${createResponse.error}");
      emit(AddArtFailure(error: createResponse.error, user: event.user));
    }
  }

  void _handleUpdateUserEvent(UpdateUserEvent event, Emitter<ArtListingState> emit) async {
    emit(UpdateUserSuccess(artList: event.artList, user: event.user));
  }
}
