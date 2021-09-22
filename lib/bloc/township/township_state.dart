part of 'township_bloc.dart';

@immutable
abstract class TownshipState {
  const TownshipState();
}

class TownshipInitial extends TownshipState {}

class TownshipLoading extends TownshipState {}

class TownshipLoaded extends TownshipState {
  List<TownshipData>? townships;
  int? page;
  bool? hasReachedMax;

  TownshipLoaded({this.townships, this.page, this.hasReachedMax});

  @override
  String toString() =>
      'TownshipsLoaded { events: ${townships?.length}, hasReachedMax: $hasReachedMax }';
}

class TownshipsError extends TownshipState {
  final String? error;

  TownshipsError({this.error});
}
