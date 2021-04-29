import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:residential/models/city.dart';
import 'package:residential/models/cityDetail.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'citydetails_state.dart';

class CitydetailsCubit extends Cubit<CitydetailsState> {
  CitydetailsCubit() : super(CitydetailsInitial());
  void fetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? time = prefs.getString("time");
    if (time != null) {
      bool isnotloaded = checkTime(time);
      if (isnotloaded)
        getData();
      else {
        String? data = prefs.getString("CityDetails");
        if (data == null)
          emit(CitydetailsError());
        else {
          CityDetails detail = CityDetails.fromJson(data);
          emit(CitydetailsLoaded(detail.details));
        }
      }
    } else {
      getData();
    }
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("cities");
    String filter = "?nh=";
    if (data == null) filter = "";

    Cities cities = Cities.fromJson(data!);
    cities.cities.forEach((element) {
      if (element.selected == true) filter += element.name + ",";
    });
    final response = await http.get(
        Uri.parse("https://api.agentroof.ca/api/featured-listings/" + filter),
        headers: {"APPKEY": "j5McQrYdEhOnAdTB0copxIEeNn3YvcWf"});

    if (response.statusCode == 200) {
      List<CityDetail> tags = [];
      List data = json.decode(response.body);
      data.forEach((element) {
        tags.add(CityDetail.fromMap(element));
      });

      prefs.setString("CityDetails", CityDetails(tags).toJson());
      prefs.setString("time", DateTime.now().toString());
      emit(CitydetailsLoaded(tags));
    } else
      emit(CitydetailsError());
  }

  bool checkTime(String? time) {
    DateTime lastTime = DateTime.tryParse(time!)!;
    final diff = lastTime.difference(DateTime.now());

    if (diff.inHours > -3) return false;
    return true;
  }
}
