import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:petai/models/pet_analysis.dart';
import 'package:petai/utils/services/firestore_service.dart';
import 'package:petai/view_models/home_controller.dart';
import 'package:petai/views/widgets/loader.dart';

class AIController extends GetxController {
  final _aiResponse = AnalyzeModel().obs;
  final _isLoading = false.obs;
  final functions = FirebaseFunctions.instance;

  Future<void> generateContent(String text, Uint8List petImage) async {
    try {
      setIsLoading(true);

      // Convert image to base64
      final String base64Image = base64Encode(petImage);

      // Call the Firebase Function
      final result = await functions.httpsCallable('analyzePet').call({
        'text': text,
        'imageBase64': base64Image,
      });

      final response = result.data;
      if (response['success']) {
        final defineResp = AnalyzeModel.fromJson(response['data']);
        await FireStoreService().setData(defineResp, petImage);
        setAiResponse(defineResp);
      } else {
        log("AI Error: ${response['error']}");
        // Handle error appropriately
      }
    } catch (e) {
      log("AI Error: $e");
    } finally {
      setIsLoading(false);
    }
  }

  AnalyzeModel get aiResponse => _aiResponse.value;
  bool get isLoading => _isLoading.value;

  void setAiResponse(AnalyzeModel value) {
    _aiResponse.value = value;
    closeLoadingDialog();
    Get.find<HomeController>().addPet(value);
  }

  void resetAiResponse() {
    _aiResponse.value = AnalyzeModel();
  }

  void setIsLoading(bool value) {
    _isLoading.value = value;
  }
}
