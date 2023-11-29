part of 'palette_bloc.dart';

sealed class PaletteState extends Equatable {
  final Color primaryColor;
  final Color secondaryColor;

  const PaletteState({required this.primaryColor, required this.secondaryColor});

  @override
  List<Object> get props => [primaryColor, secondaryColor];
}

class PaletteInitial extends PaletteState {
  const PaletteInitial({required super.primaryColor, required super.secondaryColor});
}

class PaletteUpdate extends PaletteState {
  const PaletteUpdate({required super.primaryColor, required super.secondaryColor});
}