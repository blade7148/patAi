import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  Future<Uint8List?> selectPhoto() async {
    try {
      // request for permission
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
      );

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        return bytes;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("TakePhoto Error : $e");
      return null;
    }
  }

  Future<Uint8List?> takePhoto() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        return bytes;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("TakePhoto Error : $e");
      return null;
    }
  }
}
