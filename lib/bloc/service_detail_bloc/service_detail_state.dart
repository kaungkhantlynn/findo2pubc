part of 'service_detail_bloc.dart';

@immutable
abstract class ServiceDetailState {
  const ServiceDetailState();
}

class ServiceDetailInitial extends ServiceDetailState {}

class ServiceDetailLoading extends ServiceDetailState {}

class ServiceDetailLoaded extends ServiceDetailState {
  ServiceDetailModel? serviceDetailModel;

  ServiceDetailLoaded({this.serviceDetailModel});
}

class CandidateDetailError extends ServiceDetailState {
  final String? error;

  CandidateDetailError({this.error});
}
