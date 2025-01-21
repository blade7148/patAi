import 'package:get/get.dart';
import 'package:petai/view_models/ai_controller.dart';
import 'package:petai/view_models/home_controller.dart';
import 'package:petai/view_models/image_controller.dart';
import 'package:petai/view_models/language_controller.dart';
import 'package:petai/view_models/home_tab_controller.dart';
import 'package:petai/view_models/pet_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ImageController());
    Get.put(AIController());
    Get.put(HomeController());
    Get.put(HomeTabController());
    Get.put(PetController());
    Get.put(LanguageController());
  }
}
