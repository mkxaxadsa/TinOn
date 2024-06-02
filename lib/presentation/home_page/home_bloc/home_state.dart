part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}


final class HomeLoadingState extends HomeState{}

final class HomeLoadedFullState extends HomeState{
  final List<TravelModel> travelModelList;
  final List<TravelModel> nearestThreeTravels;

  HomeLoadedFullState({ required this.nearestThreeTravels, required this.travelModelList});
}

final class HomeLoadedEmptyState extends HomeState{

}