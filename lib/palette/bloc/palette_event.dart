part of 'palette_bloc.dart';

sealed class PaletteEvent extends Equatable {
  final Color primaryColor;
  final Color secondaryColor;

  const PaletteEvent({required this.primaryColor, required this.secondaryColor});

  @override
  List<Object> get props => [primaryColor, secondaryColor];
}

final class UpdateColorsPaletteEvent extends PaletteEvent {
  const UpdateColorsPaletteEvent({required super.primaryColor, required super.secondaryColor});
}
