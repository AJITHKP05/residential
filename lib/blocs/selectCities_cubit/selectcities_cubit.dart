import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:residential/models/city.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';
part 'selectcities_state.dart';

class SelectcitiesCubit extends Cubit<SelectcitiesState> {
  SelectcitiesCubit() : super(Selectcitiesloading());
  List<City> city = [
    City("Mississauga", false),
    City("Brampton", false),
    City("Scarborough", false),
    City("Whitby", false),
    City("Oakville", false),
  ];

  fetch({bool first = false}) async {
    Cities cities = Cities(city);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    getLocalData(prefs).then((value) async {
      if (value == null)
        emit(SelectcitiesInitial(cities));
      else {
        if (first)
          emit(SelectcitiesSkip());
        else
          emit(SelectcitiesSaved(value));
      }
    });
  }

  Future<Cities?> getLocalData(SharedPreferences prefs) async {
    String? data = prefs.getString("cities");

    if (data == null) return null;

    return Cities.fromJson(data);
  }

  void saveData(Cities cities) async {
    emit(Selectcitiesloading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("cities", cities.toJson());
    prefs.remove("time");
    emit(SelectcitiesSkip());
  }
}
