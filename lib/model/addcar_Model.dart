// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddCarModels {
  String? brand;
  String? model;
  String? color;
  String? plateNumber;
  String? painting;
  String? image;
  String? uid;
  int? time;
  int? brandIndex;
  int? modelIndex;
  int? colorIndex;
  AddCarModels({
    this.brand,
    this.model,
    this.color,
    this.plateNumber,
    this.painting,
    this.image,
    this.uid,
    this.time,
    this.brandIndex,
    this.modelIndex,
    this.colorIndex,
  });


  AddCarModels copyWith({
    String? brand,
    String? model,
    String? color,
    String? plateNumber,
    String? painting,
    String? image,
    String? uid,
    int? time,
    int? brandIndex,
    int? modelIndex,
    int? colorIndex,
  }) {
    return AddCarModels(
      brand: brand ?? this.brand,
      model: model ?? this.model,
      color: color ?? this.color,
      plateNumber: plateNumber ?? this.plateNumber,
      painting: painting ?? this.painting,
      image: image ?? this.image,
      uid: uid ?? this.uid,
      time: time ?? this.time,
      brandIndex: brandIndex ?? this.brandIndex,
      modelIndex: modelIndex ?? this.modelIndex,
      colorIndex: colorIndex ?? this.colorIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brand': brand,
      'model': model,
      'color': color,
      'plateNumber': plateNumber,
      'painting': painting,
      'image': image,
      'uid': uid,
      'time': time,
      'brandIndex': brandIndex,
      'modelIndex': modelIndex,
      'colorIndex': colorIndex,
    };
  }

  factory AddCarModels.fromMap(Map<String, dynamic> map) {
    return AddCarModels(
      brand: map['brand'] != null ? map['brand'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      plateNumber: map['plateNumber'] != null ? map['plateNumber'] as String : null,
      painting: map['painting'] != null ? map['painting'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      time: map['time'] != null ? map['time'] as int : null,
      brandIndex: map['brandIndex'] != null ? map['brandIndex'] as int : null,
      modelIndex: map['modelIndex'] != null ? map['modelIndex'] as int : null,
      colorIndex: map['colorIndex'] != null ? map['colorIndex'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddCarModels.fromJson(String source) => AddCarModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddCarModels(brand: $brand, model: $model, color: $color, plateNumber: $plateNumber, painting: $painting, image: $image, uid: $uid, time: $time, brandIndex: $brandIndex, modelIndex: $modelIndex, colorIndex: $colorIndex)';
  }

  @override
  bool operator ==(covariant AddCarModels other) {
    if (identical(this, other)) return true;
  
    return 
      other.brand == brand &&
      other.model == model &&
      other.color == color &&
      other.plateNumber == plateNumber &&
      other.painting == painting &&
      other.image == image &&
      other.uid == uid &&
      other.time == time &&
      other.brandIndex == brandIndex &&
      other.modelIndex == modelIndex &&
      other.colorIndex == colorIndex;
  }

  @override
  int get hashCode {
    return brand.hashCode ^
      model.hashCode ^
      color.hashCode ^
      plateNumber.hashCode ^
      painting.hashCode ^
      image.hashCode ^
      uid.hashCode ^
      time.hashCode ^
      brandIndex.hashCode ^
      modelIndex.hashCode ^
      colorIndex.hashCode;
  }
}
