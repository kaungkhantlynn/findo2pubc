import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:o2findermyanmar/network/api_service.dart';
import 'package:o2findermyanmar/network/model/divisions_data.dart';
import 'package:o2findermyanmar/network/model/divisions_model.dart';
part 'division_event.dart';
part 'division_state.dart';

class DivisionBloc extends Bloc<DivisionEvent, DivisionState> {
  ApiService apiService = ApiService();

  DivisionBloc() : super(DivisionInitial());
  @override
  // TODO: implement initialState
  DivisionState get initialState => DivisionInitial();

  @override
  Stream<DivisionState> mapEventToState(
    DivisionEvent event,
  ) async* {
    final currentState = state;
    if (event is GetDivision) {
      try {
        int pageToFetch = 1;
        List<DivisionsData> divisionModel = [];

        if (currentState is DivisionLoaded) {
          // pageToFetch = currentState.page! + 1;
          divisionModel = currentState.divisions!;
          print(divisionModel);
        }

        DivisionsModel allDivisionsModel = await apiService.getDivisions();

        bool hasReachMax = true;
        divisionModel.addAll(allDivisionsModel.data!);

        yield DivisionLoaded(
            divisions: divisionModel,
            page: pageToFetch,
            hasReachedMax: hasReachMax);
      } catch (e) {
        print("Division_EE" + e.toString());
        DivisionsError(error: e.toString());
      }
    }
  }
}
