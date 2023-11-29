import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'palette_event.dart';
part 'palette_state.dart';

class PaletteBloc extends Bloc<PaletteEvent, PaletteState> {
  PaletteBloc() : super(const PaletteInitial(primaryColor: Colors.white, secondaryColor: Colors.black)) {
    on<PaletteEvent>((PaletteEvent event, Emitter<PaletteState> emit) {
      emit(PaletteUpdate(primaryColor: event.primaryColor, secondaryColor: event.secondaryColor));
    });
  }
}
