part of 'township_bloc.dart';

@immutable
abstract class TownshipEvent {
  const TownshipEvent();
}

class ChangeTownshipKeyword extends TownshipEvent {
  ChangeTownshipKeyword();
}

class GetTownship extends TownshipEvent {
  int? divisionId;
  GetTownship({this.divisionId});
}

class ShowDistricLoading extends TownshipEvent {}
