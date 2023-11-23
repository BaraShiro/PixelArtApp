part of 'art_listing_bloc.dart';

sealed class ArtListingEvent extends Equatable {
  const ArtListingEvent();

  @override
  List<Object> get props => [];
}

final class ListAllArtEvent extends ArtListingEvent {}
