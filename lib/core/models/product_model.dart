import 'dart:io';

import 'package:fashion_dashboard/core/entities/product_entity.dart';

class ProductModel {
  String name;
  String description;
  double price;
  File? imageFile;
  String? image;
  String? documentId;

  ProductModel({
    this.documentId,
    required this.name,
    required this.description,
    required this.price,
    this.imageFile,
    this.image,
  });
  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
    name: entity.name,
    description: entity.description,
    price: entity.price,
    imageFile: entity.imageFile,
    image: entity.image,
    documentId: entity.docmentId,
  );
  tojson() => {
    'documentId': documentId,
    'name': name,
    'description': description,
    'price': price,
    'image': image,
  };
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Ensure all required fields have default values if null
    return ProductModel(
      documentId: json['documentId']?.toString(),
      name: json['name']?.toString() ?? 'No Name',
      description: json['description']?.toString() ?? '',
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
      image: json['image']?.toString(),
    );
  }
  toEntity() => ProductEntity(
    name: name,
    description: description,
    price: price,

    image: image,
    docmentId: documentId!,
  );
}
