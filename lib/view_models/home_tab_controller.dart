import 'package:get/get.dart';

class HomeTabController extends GetxController {
  var currentTab = 0.obs;

  int get tab => currentTab.value;

  void setTab(int index) {
    if (index == currentTab.value) return;
    if (index == 2) {
      return;
    }
    currentTab.value = index;
  }
}
