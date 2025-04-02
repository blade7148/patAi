import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:petai/views/widgets/rating_dialog.dart';

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

void showRatingDialog() {
  Get.dialog(
    RatingDialog(
      onSubmit: (rating, feedback) async {
        try {
          // _hiveService.setHasRated(true);
          Get.back();
        } catch (e) {
          log("Rating Error: $e");
        }
      },
    ),
    barrierDismissible: false,
  );
}
