// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:brush/model/services_Model.dart';

class OrderModel {
  final List<ServicesModel>? services;
  String? brand;
  String? model;
  String? color;
  String? plateNumber;
  String? painting;
  String? image;
  final String? time;
  final String? date;
  final String? price;
  final String? latitude;
  final String? longitude;
  final String? address;
  final String? uid;
  final int? orderTime;
  final int? orderNumber;
  OrderModel({
    this.services,
    this.brand,
    this.model,
    this.color,
    this.plateNumber,
    this.painting,
    this.image,
    this.time,
    this.date,
    this.price,
    this.latitude,
    this.longitude,
    this.address,
    this.uid,
    this.orderTime,
    this.orderNumber,
  });

  OrderModel copyWith({
    List<ServicesModel>? services,
    String? brand,
    String? model,
    String? color,
    String? plateNumber,
    String? painting,
    String? image,
    String? time,
    String? date,
    String? price,
    String? latitude,
    String? longitude,
    String? address,
    String? uid,
    int? orderTime,
    int? orderNumber,
  }) {
    return OrderModel(
      services: services ?? this.services,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      color: color ?? this.color,
      plateNumber: plateNumber ?? this.plateNumber,
      painting: painting ?? this.painting,
      image: image ?? this.image,
      time: time ?? this.time,
      date: date ?? this.date,
      price: price ?? this.price,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      uid: uid ?? this.uid,
      orderTime: orderTime ?? this.orderTime,
      orderNumber: orderNumber ?? this.orderNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'services': services?.map((x) => x.toMap()).toList(),
      'brand': brand,
      'model': model,
      'color': color,
      'plateNumber': plateNumber,
      'painting': painting,
      'image': image,
      'time': time,
      'date': date,
      'price': price,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'uid': uid,
      'orderTime': orderTime,
      'orderNumber': orderNumber,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      services: map['services'] != null
          ? List<ServicesModel>.from(
              (map['services'] as List<dynamic>).map<ServicesModel?>(
                (x) => ServicesModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      plateNumber:
          map['plateNumber'] != null ? map['plateNumber'] as String : null,
      painting: map['painting'] != null ? map['painting'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      orderTime: map['orderTime'] != null ? map['orderTime'] as int : null,
      orderNumber:
          map['orderNumber'] != null ? map['orderNumber'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(services: $services, brand: $brand, model: $model, color: $color, plateNumber: $plateNumber, painting: $painting, image: $image, time: $time, date: $date, price: $price, latitude: $latitude, longitude: $longitude, address: $address, uid: $uid, orderTime: $orderTime, orderNumber: $orderNumber)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.services, services) &&
        other.brand == brand &&
        other.model == model &&
        other.color == color &&
        other.plateNumber == plateNumber &&
        other.painting == painting &&
        other.image == image &&
        other.time == time &&
        other.date == date &&
        other.price == price &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.address == address &&
        other.uid == uid &&
        other.orderTime == orderTime &&
        other.orderNumber == orderNumber;
  }

  @override
  int get hashCode {
    return services.hashCode ^
        brand.hashCode ^
        model.hashCode ^
        color.hashCode ^
        plateNumber.hashCode ^
        painting.hashCode ^
        image.hashCode ^
        time.hashCode ^
        date.hashCode ^
        price.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        address.hashCode ^
        uid.hashCode ^
        orderTime.hashCode ^
        orderNumber.hashCode;
  }
}
