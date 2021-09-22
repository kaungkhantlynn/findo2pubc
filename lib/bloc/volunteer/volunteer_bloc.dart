import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:o2findermyanmar/network/api_service.dart';
import 'package:o2findermyanmar/network/model/divisions_data.dart';
import 'package:o2findermyanmar/network/model/divisions_model.dart';
import 'package:o2findermyanmar/network/model/volunteers_data.dart';
import 'package:o2findermyanmar/network/model/volunteers_model.dart';
part 'volunteer_event.dart';
part 'volunteer_state.dart';

class VolunteerBloc extends Bloc<VolunteerEvent, VolunteerState> {
  ApiService apiService = ApiService();

  VolunteerBloc() : super(VolunteersInitial());
  @override
  // TODO: implement initialState
  VolunteerState get initialState => VolunteersInitial();

  @override
  Stream<VolunteerState> mapEventToState(
    VolunteerEvent event,
  ) async* {
    final currentState = state;
    if (event is GetVolunteer) {
      try {
        int pageToFetch = 1;
        List<VolunteerData> volunteerModel = [];

        if (currentState is VolunteersLoaded) {
          // pageToFetch = currentState.page! + 1;
          volunteerModel = currentState.volunteers!;
          print(volunteerModel);
        }

        VolunteersModel allVolunteersModel = await apiService.getVolunteers();

        bool hasReachMax = true;
        volunteerModel.addAll(allVolunteersModel.data!);

        yield VolunteersLoaded(
            volunteers: volunteerModel,
            page: pageToFetch,
            hasReachedMax: hasReachMax);
      } catch (e) {
        // print("Volunteer_EE" + e.toString());
        VolunteersError(error: e.toString());
      }
    }
  }
}
