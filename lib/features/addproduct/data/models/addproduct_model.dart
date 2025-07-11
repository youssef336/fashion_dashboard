import 'dart:io';

class AddproductModel {
  String name;
  String description;
  String price;
  File imageFile;
  String? image;

  AddproductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.imageFile,
    this.image,
  });
}
