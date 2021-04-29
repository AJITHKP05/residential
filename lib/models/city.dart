import 'dart:convert';

class Cities {
  final List<City> cities;

  Cities(this.cities);

  Cities copyWith({
    List<City>? cities,
  }) {
    return Cities(
      cities ?? this.cities,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cities': cities.map((x) => x.toMap()).toList(),
    };
  }

  factory Cities.fromMap(Map<String, dynamic> map) {
    return Cities(
      List<City>.from(map['cities']?.map((x) => City.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cities.fromJson(String source) => Cities.fromMap(json.decode(source));
}

class City {
  final String name;
  final bool selected;

  City(this.name, this.selected);

  City copyWith({
    String? name,
    bool? selected,
  }) {
    return City(
      name ?? this.name,
      selected ?? this.selected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'selected': selected,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      map['name'],
      map['selected'],
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source));
}
