import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:petai/utils/services/hive_service.dart';

class WelcomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    signInAnonymously();
    HiveService().onWelcomeShowed();
  }

  signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  void onWelcomeShowed() {
    // HiveService().onWelcomeShowed();
  }
}
