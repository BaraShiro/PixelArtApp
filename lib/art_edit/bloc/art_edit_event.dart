part of 'art_edit_bloc.dart';

sealed class ArtEditEvent extends Equatable {
  const ArtEditEvent();

  @override
  List<Object> get props => [];
}

final class ArtEditStartListeningEvent extends ArtEditEvent {
  final String pixelArtId;

  const ArtEditStartListeningEvent({required this.pixelArtId});

  @override
  List<Object> get props => [pixelArtId];
}

final class ArtEditUpdateEvent extends ArtEditEvent {
  final PixelArt updatedPixelArt;

  const ArtEditUpdateEvent({required this.updatedPixelArt});

  @override
  List<Object> get props => [updatedPixelArt];
}