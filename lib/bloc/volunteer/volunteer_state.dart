part of 'volunteer_bloc.dart';

@immutable
abstract class VolunteerState {
  const VolunteerState();
}

class VolunteersInitial extends VolunteerState {}

class VolunteersLoading extends VolunteerState {}

class VolunteersLoaded extends VolunteerState {
  List<VolunteerData>? volunteers;
  int? page;
  bool? hasReachedMax;

  VolunteersLoaded({this.volunteers, this.page, this.hasReachedMax});

  @override
  String toString() =>
      'VolunteersLoaded { events: ${volunteers!.length}, hasReachedMax: $hasReachedMax }';
}

class VolunteersError extends VolunteerState {
  final String? error;

  VolunteersError({this.error});
}
