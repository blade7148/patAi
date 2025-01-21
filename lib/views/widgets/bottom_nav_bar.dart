import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petai/models/tab_model.dart';
import 'package:petai/view_models/ai_controller.dart';
import 'package:petai/view_models/home_tab_controller.dart';
import 'package:petai/view_models/image_controller.dart';
import 'package:petai/views/widgets/pet_info_dialog.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    List<TabModel> tabs = [
      TabModel('home', Icons.home),
      TabModel('control', Icons.content_paste_outlined),
      TabModel(
        null,
        Container(
          decoration: const BoxDecoration(
            color: Colors.deepOrangeAccent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2.0,
                spreadRadius: 0.5,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
          width: 65.0,
          height: 65.0,
          child: RawMaterialButton(
            shape: const CircleBorder(),
            onPressed: () async {
              Get.find<AIController>().resetAiResponse();
              final isSelectedSuccessfully =
                  await Get.find<ImageController>().selectImage();
              if (!isSelectedSuccessfully) {
                return;
              }
              showCustomDialog(
                onValue: (value) {
                  if (value == null) return;
                },
              );
            },
            child: const Icon(
              Icons.photo_camera_rounded,
              size: 36.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
      TabModel('history', Icons.history),
      TabModel('profile', Icons.person_rounded),
    ];

    return ConvexAppBar(
      backgroundColor: Colors.white,
      style: TabStyle.fixedCircle,
      height: 56,
      top: -27,
      curveSize: 83,
      elevation: 2,
      items: tabs
          .map(
            (e) => TabItem(
              icon: e.icon,
              title: e.title?.tr,
            ),
          )
          .toList(),
      activeColor: Colors.deepOrange,
      color: Colors.grey,
      controller: tabController,
      onTap: (index) {
        Get.find<HomeTabController>().setTab(index);
      },
    );

    // return ConvexAppBar(
    //   height: 56,
    //   initialActiveIndex: 0,
    //   style: TabStyle.fixedCircle,
    //   backgroundColor: Colors.white,
    //   activeColor: Colors.orange,
    //   color: Colors.grey,
    //   disableDefaultTabController: true,
    //   items: [
    //     const TabItem(
    //       icon: Icons.home,
    //       title: 'Home',
    //     ),
    //     const TabItem(
    //       icon: Icons.map,
    //       title: 'Discovery',
    //     ),
    //     TabItem(
    //       icon: Container(
    //         decoration: const BoxDecoration(
    //           color: Colors.orange,
    //           shape: BoxShape.circle,
    //         ),
    //         child: const Icon(
    //           Icons.camera_alt_rounded,
    //           size: 36,
    //           color: Colors.white,
    //         ),
    //       ),
    //     ),
    //     const TabItem(
    //       icon: Icons.message,
    //       title: 'Message',
    //     ),
    //     const TabItem(
    //       icon: Icons.people,
    //       title: 'Profile',
    //     ),
    //   ],
    //   onTap: (int i) => print('click index=$i'),
    // );
  }
}
