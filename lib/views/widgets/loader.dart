import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

void showLoadingDialog({bool? isPop}) {
  SmartDialog.showLoading(
    clickMaskDismiss: false,
    msg: "loading".tr,
    animationBuilder: (
      controller,
      child,
      animationParam,
    ) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        width: 100.0,
        height: 100.0,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    },
    onMask: () {
      if (isPop != null) {
        Get.rootController.didPopRoute();
      }
    },
  );
}

Future<void> closeLoadingDialog() async {
  // check if dialog is already dismissed
  await SmartDialog.dismiss(
    status: SmartStatus.loading,
  );
}
