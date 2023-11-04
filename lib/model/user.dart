// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? image;
  String? uid;
  int? walatBalance;
  String? token;
  String? cityName;
  UserModel({
    this.name,
    this.phone,
    this.email,
    this.password,
    this.image,
    this.uid,
    this.walatBalance,
    this.token,
    this.cityName,
  });

  UserModel copyWith({
    String? name,
    String? phone,
    String? email,
    String? password,
    String? image,
    String? uid,
    int? walatBalance,
    String? token,
    String? cityName,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      image: image ?? this.image,
      uid: uid ?? this.uid,
      walatBalance: walatBalance ?? this.walatBalance,
      token: token ?? this.token,
      cityName: cityName ?? this.cityName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'image': image,
      'uid': uid,
      'walatBalance': walatBalance,
      'token': token,
      'cityName': cityName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      walatBalance: map['walatBalance'] != null ? map['walatBalance'] as int : null,
      token: map['token'] != null ? map['token'] as String : null,
      cityName: map['cityName'] != null ? map['cityName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, phone: $phone, email: $email, password: $password, image: $image, uid: $uid, walatBalance: $walatBalance, token: $token, cityName: $cityName)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.phone == phone &&
      other.email == email &&
      other.password == password &&
      other.image == image &&
      other.uid == uid &&
      other.walatBalance == walatBalance &&
      other.token == token &&
      other.cityName == cityName;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      password.hashCode ^
      image.hashCode ^
      uid.hashCode ^
      walatBalance.hashCode ^
      token.hashCode ^
      cityName.hashCode;
  }
}
