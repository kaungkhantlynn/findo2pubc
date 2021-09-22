part of 'volunteer_bloc.dart';

@immutable
abstract class VolunteerEvent {
  const VolunteerEvent();
}

class GetVolunteer extends VolunteerEvent {
  GetVolunteer();
}

class ShowVolunteerLoading extends VolunteerEvent {}

class RefreshVolunteer extends VolunteerEvent {
  RefreshVolunteer();
}

class ResetVolunteer extends VolunteerEvent {
  DivisionsModel? divisionsModel;
  int? page;

  ResetVolunteer({this.divisionsModel, this.page});
}
