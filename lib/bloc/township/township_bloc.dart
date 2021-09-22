import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:o2findermyanmar/network/api_service.dart';
import 'package:o2findermyanmar/network/model/township_data.dart';
import 'package:o2findermyanmar/network/model/township_model.dart';
part 'township_event.dart';
part 'township_state.dart';

class TownshipBloc extends Bloc<TownshipEvent, TownshipState> {
  TownshipBloc() : super(TownshipInitial());
  ApiService apiService = ApiService();
  @override
  Stream<TownshipState> mapEventToState(
    TownshipEvent event,
  ) async* {
    final currentState = state;

    if (event is ChangeTownshipKeyword) {
      yield TownshipInitial();
    }

    if (event is GetTownship) {
      try {
        int pageToFetch = 1;
        List<TownshipData> townshipModel = [];

        if (currentState is TownshipLoaded) {
          pageToFetch = currentState.page! + 1;
          townshipModel = currentState.townships!;
        }

        TownshipModel allTownshipModel =
            await apiService.getTownships(event.divisionId!);
        bool hasReachMax = true;
        townshipModel.addAll(allTownshipModel.data!);

        yield TownshipLoaded(
            townships: townshipModel,
            page: pageToFetch,
            hasReachedMax: hasReachMax);
      } catch (e) {
//        print("TownshipErr"+e.toString());
        TownshipsError(error: e.toString());
      }
    }
  }

  @override
  // TODO: implement initialState
  TownshipState get initialState => TownshipInitial();
}
