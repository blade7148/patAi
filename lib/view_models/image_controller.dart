import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:petai/utils/locator.dart';
import 'package:petai/utils/services/image_service.dart';

class ImageController extends GetxController {
  Uint8List imageToAnalyze = Uint8List(0);

  Future<bool> selectImage() async {
    try {
      final selectedImage = await appLocator<ImageService>().selectPhoto();
      if (selectedImage != null) {
        imageToAnalyze = selectedImage;
        return true;
      } else {
        print("No image selected");
        return false;
      }
    } catch (e) {
      print("Error selecting image: $e");
      return false;
    }
  }

  Future<void> takePhoto() async {
    try {
      final takenImage = await appLocator<ImageService>().takePhoto();
      if (takenImage != null) {
        imageToAnalyze = takenImage;
      } else {
        print("No image taken");
      }
    } catch (e) {
      print("Error taking photo: $e");
    }
  }
}
