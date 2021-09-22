part of 'division_bloc.dart';

@immutable
abstract class DivisionState {
  const DivisionState();
}

class DivisionInitial extends DivisionState {}

class DivisionLoading extends DivisionState {}

class DivisionLoaded extends DivisionState {
  List<DivisionsData>? divisions;
  int? page;
  bool? hasReachedMax;

  DivisionLoaded({this.divisions, this.page, this.hasReachedMax});

  @override
  String toString() =>
      'DivisionsLoaded { events: ${divisions!.length}, hasReachedMax: $hasReachedMax }';
}

class DivisionsError extends DivisionState {
  final String? error;

  DivisionsError({this.error});
}
