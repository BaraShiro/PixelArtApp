part of 'art_listing_bloc.dart';

sealed class ArtListingState extends Equatable {
  const ArtListingState();

  @override
  List<Object> get props => [];
}

final class ArtListingInitial extends ArtListingState {}

final class ArtListingInProgress extends ArtListingState {}

final class ArtListingSuccess extends ArtListingState {
  final List<PixelArt> artList;
  final Participant user;

  const ArtListingSuccess({required this.artList, required this.user});

  @override
  List<Object> get props => [artList, user];
}

final class ArtListingFailure extends ArtListingState {
  final Object? error;
  final Participant user;

  const ArtListingFailure({required this.error, required this.user});

  @override
  List<Object> get props => error == null ? [user] :[error!, user];
}

final class ListAllArtInProgress extends ArtListingInProgress {}

final class ListAllArtSuccess extends ArtListingSuccess {
  const ListAllArtSuccess({required super.artList, required super.user});
}

final class ListAllArtFailure extends ArtListingFailure {
  const ListAllArtFailure({required super.error, required super.user});
}

final class DeleteArtInProgress extends ArtListingInProgress {}

final class DeleteArtSuccess extends ArtListingSuccess {
  const DeleteArtSuccess({required super.artList, required super.user});
}

final class DeleteArtFailure extends ArtListingFailure {
  const DeleteArtFailure({required super.error, required super.user});
}

final class AddArtInProgress extends ArtListingInProgress {}

final class AddArtSuccess extends ArtListingSuccess {
  const AddArtSuccess({required super.artList, required super.user});
}

final class AddArtFailure extends ArtListingFailure {
  const AddArtFailure({required super.error, required super.user});
}

final class UpdateUserSuccess extends ArtListingSuccess {
  const UpdateUserSuccess({required super.artList, required super.user});
}