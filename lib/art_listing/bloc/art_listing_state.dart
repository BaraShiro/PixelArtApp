part of 'art_listing_bloc.dart';

sealed class ArtListingState extends Equatable {
  const ArtListingState();
}

class ArtListingInitial extends ArtListingState {
  @override
  List<Object> get props => [];
}
