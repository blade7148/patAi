import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petai/view_models/image_controller.dart';
import 'package:petai/views/widgets/image_widget.dart';
import 'package:petai/views/widgets/pet_info_form.dart';

void showPetInfoSheet() {
  if (Get.context == null) return;
  PetInfoBottomSheet.show();
}

// This can be used if you want to show the image preview in a dialog before the form
void showImagePreviewDialog() {
  if (Get.context == null) return;

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "pet_info".tr,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 24.h),
            ItemImageView(
              bytes: Get.find<ImageController>().imageToAnalyze,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  PetInfoBottomSheet.show();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "continue".tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
