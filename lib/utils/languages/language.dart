import 'package:get/get.dart';
import 'package:petai/utils/languages/en.dart';
import 'package:petai/utils/languages/tr.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'tr': trLang,
        'en': enLang,
      };
}
