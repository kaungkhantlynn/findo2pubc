part of 'division_bloc.dart';

@immutable
abstract class DivisionEvent {
  const DivisionEvent();
}

class GetDivision extends DivisionEvent {
  GetDivision();
}

class ShowDivisionLoading extends DivisionEvent {}

class RefreshDivision extends DivisionEvent {
  RefreshDivision();
}

class ResetDivision extends DivisionEvent {
  DivisionsModel? divisionsModel;
  int? page;

  ResetDivision({this.divisionsModel, this.page});
}
