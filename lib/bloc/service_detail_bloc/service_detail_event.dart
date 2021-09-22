part of 'service_detail_bloc.dart';

@immutable
abstract class ServiceDetailEvent {
  const ServiceDetailEvent();
}

class GetServiceDetail extends ServiceDetailEvent {
  String? id;

  GetServiceDetail({this.id});
}

class ShowServiceLoading extends ServiceDetailEvent {}

class RefreshService extends ServiceDetailEvent {
  RefreshService();
}

class ResetServiceDetail extends ServiceDetailEvent {
  ServiceDetailModel? serviceDetailModel;
  int? page;

  ResetServiceDetail({this.serviceDetailModel, this.page});
}
