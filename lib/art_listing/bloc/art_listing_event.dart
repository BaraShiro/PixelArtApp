part of 'art_listing_bloc.dart';

sealed class ArtListingEvent extends Equatable {
  final Participant user;

  const ArtListingEvent({required this.user});

  @override
  List<Object> get props => [user];
}

final class ListAllArtEvent extends ArtListingEvent {
  const ListAllArtEvent({required super.user});
}

final class DeleteArtEvent extends ArtListingEvent {
  final String id;

  const DeleteArtEvent({required this.id, required super.user});

  @override
  List<Object> get props => [id, user];
}

final class AddArtEvent extends ArtListingEvent {
  final PixelArt newArt;

  const AddArtEvent({required this.newArt, required super.user});

  @override
  List<Object> get props => [newArt, user];
}

final class UpdateUserEvent extends ArtListingEvent {
  final List<PixelArt> artList;
  const UpdateUserEvent({required this.artList, required super.user});

  @override
  List<Object> get props => [artList, user];
}