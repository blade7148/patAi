import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:petai/models/pet_analysis.dart';
import 'package:petai/utils/env.dart';
import 'package:petai/utils/services/firestore_service.dart';
import 'package:petai/view_models/home_controller.dart';
import 'package:petai/views/widgets/loader.dart';

class AIController extends GetxController {
  final _aiResponse = AnalyzeModel().obs;
  final _isLoading = false.obs;

  late final GenerativeModel model;

  @override
  void onInit() {
    super.onInit();
    model = GenerativeModel(
      model: "gemini-1.5-flash",
      generationConfig: GenerationConfig(responseMimeType: "application/json"),
      apiKey: Env.key,
      systemInstruction: Content.system(
        "system_prompt".tr,
      ),
    );
  }

  Future<void> generateContent(String text, Uint8List petImage) async {
    try {
      setIsLoading(true);
      final imageParts = [
        DataPart('image/jpeg', petImage),
      ];
      final response = await model.generateContent([
        Content.multi([TextPart(text), ...imageParts])
      ]);
      final defineResp = AnalyzeModel.fromJson(jsonDecode(response.text!));

      await FireStoreService().setData(defineResp, petImage);
      setAiResponse(defineResp);
      setIsLoading(false);
    } catch (e) {
      log("AI Error : $e");
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
