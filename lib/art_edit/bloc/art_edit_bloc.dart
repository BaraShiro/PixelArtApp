import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'art_edit_event.dart';
part 'art_edit_state.dart';

class ArtEditBloc extends Bloc<ArtEditEvent, ArtEditState> {
  ArtEditBloc() : super(ArtEditInitial()) {
    on<ArtEditEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
