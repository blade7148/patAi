import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petai/utils/languages/util.dart';

class LanguageController extends GetxController {
  final _storage = GetStorage();

  final _language = 'tr'.obs;
  String get language => _language.value;

  @override
  void onInit() {
    super.onInit();
    _language.value = _storage.read('language') ?? getLanguageCode();
  }

  void changeLanguage(String language) {
    _storage.write('language', language);
    _language.value = language;
    Get.updateLocale(Locale(language));
  }
}
