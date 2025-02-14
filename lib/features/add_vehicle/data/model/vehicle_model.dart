// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleModel {
  final String? id;
  final String name;
  final num fuelEfficiency;
  final num manufacturingYear;
  final String? imageUrl;
  Timestamp createdAt;
  VehicleModel({
    this.id,
    required this.name,
    required this.fuelEfficiency,
    required this.manufacturingYear,
    this.imageUrl,
    required this.createdAt,
  });

  VehicleModel copyWith({
    String? id,
    String? name,
    num? fuelEfficiency,
    num? manufacturingYear,
    String? imageUrl,
    Timestamp? createdAt,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      fuelEfficiency: fuelEfficiency ?? this.fuelEfficiency,
      manufacturingYear: manufacturingYear ?? this.manufacturingYear,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'fuelEfficiency': fuelEfficiency,
      'manufacturingYear': manufacturingYear,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      fuelEfficiency: map['fuelEfficiency'] as num,
      manufacturingYear: map['manufacturingYear'] as num,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      createdAt: map['createdAt'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleModel.fromJson(String source) => VehicleModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
