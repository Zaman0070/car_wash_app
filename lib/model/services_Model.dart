// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServicesModel {
  final String? serviceName;
  final String? servicePrice;
  final String? serviceImage;
  ServicesModel({
    this.serviceName,
    this.servicePrice,
    this.serviceImage,
  });

  ServicesModel copyWith({
    String? serviceName,
    String? servicePrice,
    String? serviceImage,
  }) {
    return ServicesModel(
      serviceName: serviceName ?? this.serviceName,
      servicePrice: servicePrice ?? this.servicePrice,
      serviceImage: serviceImage ?? this.serviceImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceName': serviceName,
      'servicePrice': servicePrice,
      'serviceImage': serviceImage,
    };
  }

  factory ServicesModel.fromMap(Map<String, dynamic> map) {
    return ServicesModel(
      serviceName: map['serviceName'] != null ? map['serviceName'] as String : null,
      servicePrice: map['servicePrice'] != null ? map['servicePrice'] as String : null,
      serviceImage: map['serviceImage'] != null ? map['serviceImage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServicesModel.fromJson(String source) => ServicesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ServicesModel(serviceName: $serviceName, servicePrice: $servicePrice, serviceImage: $serviceImage)';

  @override
  bool operator ==(covariant ServicesModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.serviceName == serviceName &&
      other.servicePrice == servicePrice &&
      other.serviceImage == serviceImage;
  }

  @override
  int get hashCode => serviceName.hashCode ^ servicePrice.hashCode ^ serviceImage.hashCode;
}
