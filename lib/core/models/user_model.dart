import 'package:hive_ce_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
   String? password;
  @HiveField(3)
  String? countryCode;
  @HiveField(4)
  String? countryName;

  UserModel({
    required this.name,
    required this.email,
     this.password,
    this.countryCode,
    this.countryName,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'countryCode': countryCode,
      'countryName': countryName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      countryCode: map['countryCode'] as String,
      countryName: map['countryName'] as String,
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? countryCode,
    String? countryName,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
    );
  }
}
