// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageFeild extends StatefulWidget {
  const ImageFeild({super.key, required this.onImageSelected});
  final ValueChanged<File?> onImageSelected;
  @override
  State<ImageFeild> createState() => _ImageFeildState();
}

class _ImageFeildState extends State<ImageFeild> {
  bool isLoading = false;
  File? fileImage;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () async {
          isLoading = true;
          setState(() {});
          try {
            await Pickimage();
          } on Exception {
            isLoading = false;
            setState(() {});
          }
          isLoading = false;
          setState(() {});
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),

                border: Border.all(color: Colors.grey),
              ),
              child: fileImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(fileImage!),
                    )
                  : const Icon(size: 180, Icons.image_outlined),
            ),
            Visibility(
              visible: fileImage != null,
              child: IconButton(
                onPressed: () {
                  fileImage = null;
                  widget.onImageSelected(fileImage);
                  setState(() {});
                },
                icon: const Icon(Icons.close, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> Pickimage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    fileImage = File(image!.path);
    widget.onImageSelected(fileImage);
  }
}
