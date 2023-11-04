// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LocationModel {
  String? latitude;
  String? longitude;
  String? address;
  String? addressType;
  String? addressDetails;
  String? uid;
  String? cityName;
  int? index;
  LocationModel({
    this.latitude,
    this.longitude,
    this.address,
    this.addressType,
    this.addressDetails,
    this.uid,
    this.cityName,
    this.index,
  });

  LocationModel copyWith({
    String? latitude,
    String? longitude,
    String? address,
    String? addressType,
    String? addressDetails,
    String? uid,
    String? cityName,
    int? index,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      addressType: addressType ?? this.addressType,
      addressDetails: addressDetails ?? this.addressDetails,
      uid: uid ?? this.uid,
      cityName: cityName ?? this.cityName,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'addressType': addressType,
      'addressDetails': addressDetails,
      'uid': uid,
      'cityName': cityName,
      'index': index,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      addressType: map['addressType'] != null ? map['addressType'] as String : null,
      addressDetails: map['addressDetails'] != null ? map['addressDetails'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      cityName: map['cityName'] != null ? map['cityName'] as String : null,
      index: map['index'] != null ? map['index'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationModel(latitude: $latitude, longitude: $longitude, address: $address, addressType: $addressType, addressDetails: $addressDetails, uid: $uid, cityName: $cityName, index: $index)';
  }

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.address == address &&
      other.addressType == addressType &&
      other.addressDetails == addressDetails &&
      other.uid == uid &&
      other.cityName == cityName &&
      other.index == index;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
      longitude.hashCode ^
      address.hashCode ^
      addressType.hashCode ^
      addressDetails.hashCode ^
      uid.hashCode ^
      cityName.hashCode ^
      index.hashCode;
  }
}
