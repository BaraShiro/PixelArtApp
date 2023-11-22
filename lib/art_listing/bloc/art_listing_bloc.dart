import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'art_listing_event.dart';
part 'art_listing_state.dart';

class ArtListingBloc extends Bloc<ArtListingEvent, ArtListingState> {
  ArtListingBloc() : super(ArtListingInitial()) {
    on<ArtListingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
