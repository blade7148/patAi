import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petai/utils/constants.dart';

import 'package:petai/view_models/home_tab_controller.dart';
import 'package:petai/views/sections/history_section.dart';
import 'package:petai/views/sections/home_section.dart';
import 'package:petai/views/sections/profile_section.dart';

import 'package:petai/views/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _sections = <Widget>[
    const HomeSection(),
    const Center(
      child: Text('Control'),
    ),
    Container(),
    const HistorySection(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final TabController tabController = TabController(
      length: Constants.tabLength,
      vsync: this,
      initialIndex: Get.find<HomeTabController>().tab,
    );

    return Scaffold(
      bottomNavigationBar: BottomNavBar(tabController: tabController),
      body: Obx(
        () => IndexedStack(
          index: Get.find<HomeTabController>().tab,
          children: _sections,
        ),
      ),
    );
  }
}
