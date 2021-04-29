import 'dart:convert';

class CityDetails {
  final List<CityDetail> details;

  CityDetails(this.details);

  CityDetails copyWith({
    List<CityDetail>? details,
  }) {
    return CityDetails(
      details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'details': details.map((x) => x.toMap()).toList(),
    };
  }

  factory CityDetails.fromMap(Map<String, dynamic> map) {
    return CityDetails(
      List<CityDetail>.from(map['details']?.map((x) => CityDetail.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CityDetails.fromJson(String source) =>
      CityDetails.fromMap(json.decode(source));
}

class CityDetail {
  final String address;
  final String city;
  final String sqft;
  final String province;
  final String price;
  final String bedroom;
  final String bathrooms;
  final Images image;

  CityDetail(this.address, this.city, this.province, this.price, this.bedroom,
      this.bathrooms, this.image, this.sqft);

  CityDetail copyWith(
      {String? address,
      String? city,
      String? province,
      String? price,
      String? bedroom,
      String? bathrooms,
      Images? image,
      String? sqft}) {
    return CityDetail(
      address ?? this.address,
      city ?? this.city,
      province ?? this.province,
      price ?? this.price,
      bedroom ?? this.bedroom,
      bathrooms ?? this.bathrooms,
      image ?? this.image,
      sqft ?? this.sqft,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'addr': address,
      'municipality': city,
      'county': province,
      'lp_dol': price,
      'br': bedroom,
      'bath_tot': bathrooms,
      'images': image.toMap(),
      'sqft': sqft
    };
  }

  factory CityDetail.fromMap(Map<String, dynamic> map) {
    return CityDetail(
      map['addr'],
      map['municipality'],
      map['county'],
      map['lp_dol'],
      map['br'],
      map['bath_tot'],
      Images.fromMap(map['images']),
      map['sqft'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CityDetail.fromJson(String source) =>
      CityDetail.fromMap(json.decode(source));
}

class Images {
  final int id;
  final String num;
  final String directory;
  final String? images;

  Images(this.id, this.num, this.directory, this.images);

  Images copyWith({
    int? id,
    String? num,
    String? directory,
    String? images,
  }) {
    return Images(
      id ?? this.id,
      num ?? this.num,
      directory ?? this.directory,
      images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ml_num': num,
      'directory': directory,
      'images': images,
    };
  }

  factory Images.fromMap(Map<String, dynamic> map) {
    return Images(
      map['id'],
      map['ml_num'],
      map['directory'],
      map['images'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Images.fromJson(String source) => Images.fromMap(json.decode(source));
  // factory Images.getImageList() {
  //   return "ghb";
  // }
}
