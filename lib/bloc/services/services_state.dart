part of 'services_bloc.dart';

@immutable
abstract class ServicesState {
  const ServicesState();
  @override
  List<Object> get props => [];
}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  List<ServicesData>? services;
  int? page;
  bool? hasReachedMax;

  ServicesLoaded({this.services, this.page, this.hasReachedMax});

  @override
  String toString() =>
      'ServicesLoaded { events: ${services?.length}, loadNoMore: $hasReachedMax }';
}

class ServicesError extends ServicesState {
  final String? error;

  ServicesError({this.error});
}
