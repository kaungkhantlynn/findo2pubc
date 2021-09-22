import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:o2findermyanmar/network/api_service.dart';
import 'package:o2findermyanmar/network/model/services_data.dart';
import 'package:o2findermyanmar/network/model/services_model.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial());
  ApiService apiService = ApiService();

  @override
  Stream<ServicesState> mapEventToState(
    ServicesEvent event,
  ) async* {
    var currentState = state;

    if (event is ChangeServicesKeyword) {
      yield ServicesInitial();
    }
    if (event is RefreshServices) {
      yield ServicesInitial();
    }

    if (event is ShowServicesLoading) {
      yield ServicesLoading();
    }

    if (event is GetServices) {
      yield* mapEventServices(event, currentState);
    }
  }

  Stream<ServicesState> mapEventServices(
      ServicesEvent event, ServicesState currentState) async* {
    final currentState = state;
    if (event is GetServices) {
      print('REFRESH_DIVID' + event.divisionId.toString());
      print('REFRESH_TOWNSHIPID' + event.townshipId.toString());
      try {
        int pageToFetch = 1;
        List<ServicesData> servicesModel = [];

        if (currentState is ServicesInitial) {
          pageToFetch = 1;
          servicesModel.clear();
        }

        if (currentState is ServicesLoaded) {
          pageToFetch = currentState.page! + 1;
          servicesModel = currentState.services!;
        }
        print('PAGENO' + pageToFetch.toString());
        ServicesModel allServicesModel = await apiService.getServices(
            event.divisionId!, event.townshipId!, pageToFetch);

        bool hasReachMax = allServicesModel.meta!.currentPage <=
                allServicesModel.meta!.lastPage
            ? false
            : true;

        servicesModel.addAll(allServicesModel.data!);

        print("PAGETOFETCH" + pageToFetch.toString());
        print(
            "METACURRENTPAGE " + allServicesModel.meta!.currentPage.toString());
        print("METALASTPAGE " + allServicesModel.meta!.lastPage.toString());

        // bool hasReachMax =
        // servicesModel.addAll(allServicesModel.data!);

        yield ServicesLoaded(
            services: servicesModel,
            page: pageToFetch,
            hasReachedMax: hasReachMax);

        print(pageToFetch);
      } catch (e) {
        print("ServiceError" + e.toString());
        ServicesError(error: e.toString());
      }
    }
  }

  @override
  // TODO: implement initialState
  ServicesState get initialState => ServicesInitial();
}
