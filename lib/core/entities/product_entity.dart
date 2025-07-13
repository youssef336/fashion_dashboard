import 'dart:io';

import 'package:uuid/uuid.dart';

class ProductEntity {
  String name;
  String description;
  double price;
  File? imageFile;
  String? image;
  String docmentId = const Uuid().v4();

  ProductEntity({
    required this.docmentId,
    required this.name,
    required this.description,
    required this.price,
    this.imageFile,
    this.image,
  });
}
