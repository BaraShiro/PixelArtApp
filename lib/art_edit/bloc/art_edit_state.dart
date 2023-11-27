part of 'art_edit_bloc.dart';

sealed class ArtEditState extends Equatable {
  const ArtEditState();

  @override
  List<Object> get props => [];
}

class ArtEditInitial extends ArtEditState {}

final class ArtEditUpdate extends ArtEditState {
  final PixelArt art;

  const ArtEditUpdate({required this.art});

  @override
  List<Object> get props => [art];
}

final class ArtEditFailure extends ArtEditState {
  final Object? error;

  const ArtEditFailure({required this.error});

  @override
  List<Object> get props => error == null ? [] : [error!];
}