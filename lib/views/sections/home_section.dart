import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petai/utils/constants.dart';
import 'package:petai/view_models/home_controller.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.appName,
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            // SizedBox(
            // height: 350,
            // child: Stack(
            //   fit: StackFit.expand,
            //   children: [
            //     Image.asset(
            //       "assets/images/home_slider.png",
            //       fit: BoxFit.cover,
            //     ),
            //     Container(
            //       color: Colors.black.withOpacity(0.3),
            //       child: const Center(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               'Analyze your pet\'s\nbreed and age with\nPet AI',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 32,
            //                 fontWeight: FontWeight.w800,
            //               ),
            //               textAlign: TextAlign.center,
            //             ),
            //             SizedBox(height: 10),
            //             Text(
            //               'Upload a photo or take a picture to get started',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 13,
            //               ),
            //               textAlign: TextAlign.center,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // ),
            Container(
              height: 140,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.pets,
                        size: 32,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'analyze'.tr,
                        style: const TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const Image(
                    image: AssetImage('assets/backgrounds/Spline.png'),
                    width: 100,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              height: 140,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.health_and_safety_sharp,
                        size: 32,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'control'.tr,
                        style: const TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const Image(
                    image: AssetImage('assets/icon/logo_splash.png'),
                    width: 100,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.pets.length,
                  itemBuilder: (context, index) {
                    final pet = controller.pets[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: pet.pet!.imageUrl != null
                            ? NetworkImage(pet.pet!.imageUrl!)
                            : NetworkImage(
                                'https://placedog.net/100/100?id=${index + 1}'),
                      ),
                      title: Text(pet.pet!.name!),
                      subtitle: Text(
                          '${pet.pet!.breed} ${pet.pet!.age?.toLowerCase() == "unknown" ? "" : "(${pet.pet!.age})"}'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
