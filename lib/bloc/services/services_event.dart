part of 'services_bloc.dart';

@immutable
abstract class ServicesEvent {
  const ServicesEvent();
}

class ChangeServicesKeyword extends ServicesEvent {
  ChangeServicesKeyword();
}

class GetServices extends ServicesEvent {
  String? divisionId;
  String? townshipId;

  GetServices({this.divisionId, this.townshipId});
}

class RefreshServices extends ServicesEvent {
  RefreshServices();
}

class ShowServicesLoading extends ServicesEvent {}
