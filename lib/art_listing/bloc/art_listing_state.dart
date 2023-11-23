part of 'art_listing_bloc.dart';

sealed class ArtListingState extends Equatable {
  const ArtListingState();

  @override
  List<Object> get props => [];
}

final class ArtListingInitial extends ArtListingState {}

final class ListAllArtInProgress extends ArtListingState {}

final class ListAllArtSuccess extends ArtListingState {
  final List<PixelArt> artList;

  const ListAllArtSuccess({required this.artList});

  @override
  List<Object> get props => [artList];
}

final class ListAllArtFailure extends ArtListingState {
  final Object? error;

  const ListAllArtFailure({required this.error});

  @override
  List<Object> get props => error == null ? [] :[error!];
}