part of 'selectcities_cubit.dart';

@immutable
abstract class SelectcitiesState extends Equatable {}

class Selectcitiesloading extends SelectcitiesState {
  @override
  List<Object?> get props => [];
}

class SelectcitiesInitial extends SelectcitiesState {
  final Cities cities;

  SelectcitiesInitial(this.cities);

  @override
  List<Object?> get props => [this.cities];
}

class SelectcitiesSaved extends SelectcitiesState {
  final Cities cities;

  SelectcitiesSaved(this.cities);

  @override
  List<Object?> get props => [this.cities];
}

class SelectcitiesError extends SelectcitiesState {
  @override
  List<Object?> get props => [];
}

class SelectcitiesSkip extends SelectcitiesState {
  @override
  List<Object?> get props => [];
}
