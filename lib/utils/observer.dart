// create a navigation observer to handle navigation events, if user back from analysis result page, show rating dialog
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:petai/utils/helper.dart';
import 'package:petai/utils/services/hive_service.dart';

class MyObserver extends NavigatorObserver {
  @override
  Future<void> didPop(
      Route<dynamic> route, Route<dynamic>? previousRoute) async {
    super.didPop(route, previousRoute);
    if (previousRoute?.settings.name == '/analysis_result') {
      if (!HiveService().hasRatedFirstTime) {
        await Future.delayed(const Duration(seconds: 1));
        showRatingDialog();
        HiveService().setHasRatedFirstTime(true);
      } else if (!HiveService().hasRatedSecondTime) {
        await Future.delayed(const Duration(seconds: 1));
        InAppReview.instance.requestReview();
        HiveService().setHasRatedSecondTime(true);
      }
    }
  }
}
