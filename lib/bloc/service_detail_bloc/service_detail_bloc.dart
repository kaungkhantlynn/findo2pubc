import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:o2findermyanmar/network/api_service.dart';
import 'package:o2findermyanmar/network/model/service_detail_model.dart';

part 'service_detail_event.dart';
part 'service_detail_state.dart';

class ServiceDetailBloc extends Bloc<ServiceDetailEvent, ServiceDetailState> {
  ServiceDetailBloc() : super(ServiceDetailInitial());

  ApiService apiService = ApiService();

  @override
  Stream<ServiceDetailState> mapEventToState(
    ServiceDetailEvent event,
  ) async* {
    if (event is GetServiceDetail) {
      yield* _mapEventSlugChange(event);
    }
  }

  Stream<ServiceDetailState> _mapEventSlugChange(
      GetServiceDetail event) async* {
    yield ServiceDetailLoading();

    try {
      ServiceDetailModel serviceDetailModel =
          await apiService.getServiceDetail(event.id!);
      yield ServiceDetailLoaded(serviceDetailModel: serviceDetailModel);
    } catch (e) {
//      print("error msg ${e.toString()}");
      yield CandidateDetailError(error: e.toString());
    }
  }

  @override
  // TODO: implement initialState
  ServiceDetailState get initialState => ServiceDetailInitial();
}
