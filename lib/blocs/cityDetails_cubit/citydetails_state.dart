part of 'citydetails_cubit.dart';

abstract class CitydetailsState extends Equatable {
  const CitydetailsState();

  @override
  List<Object> get props => [];
}

class CitydetailsInitial extends CitydetailsState {}

class CitydetailsLoaded extends CitydetailsState {
  final List<CityDetail> details;

  CitydetailsLoaded(this.details);
  @override
  List<Object> get props => [details];
}

class CitydetailsError extends CitydetailsState {}
