import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:get/get.dart';
import 'package:petai/models/pet_analysis.dart';
import 'package:petai/utils/services/firestore_service.dart';

class HomeController extends GetxController {
  final pets = <AnalyzeModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    FireStoreService().getData().then((value) => pets.assignAll(value));
    await initPlugin();
  }

  Future<void> initPlugin() async {
    await AppTrackingTransparency.trackingAuthorizationStatus;
  }

  void addPet(AnalyzeModel pet) {
    pets.add(pet);
  }

  void removePet(AnalyzeModel pet) {
    pets.remove(pet);
  }
}
