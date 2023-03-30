// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';






class ProductModel {
  final String name;
  final String cover;
  final String details;
  final String price;
  
  ProductModel({
    required this.name,
    required this.cover,
    required this.details,
    required this.price,
  });

  ProductModel copyWith({
    String? name,
    String? cover,
    String? details,
    String? price,
  }) {
    return ProductModel(
      name: name ?? this.name,
      cover: cover ?? this.cover,
      details: details ?? this.details,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cover': cover,
      'details': details,
      'price': price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      cover: map['cover'] as String,
      details: map['details'] as String,
      price: map['price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(name: $name, cover: $cover, details: $details, price: $price)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.cover == cover &&
      other.details == details &&
      other.price == price;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      cover.hashCode ^
      details.hashCode ^
      price.hashCode;
  }



}

