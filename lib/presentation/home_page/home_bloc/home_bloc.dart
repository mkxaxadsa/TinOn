import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/data_manager.dart';
import '../../../data/models/travel_model/travel_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeGetEvent>(_onGetData);
  }

  _onGetData(HomeGetEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    List<TravelModel> travelModel = await DataManager.loadTravelList();
    List<TravelModel> nearestTravelModel = await DataManager.getNearestTravels();

    if (travelModel.isEmpty) {
      emit(HomeLoadedEmptyState());
    } else {
      emit(HomeLoadedFullState(travelModelList: travelModel, nearestThreeTravels: nearestTravelModel));
    }
  }
}
