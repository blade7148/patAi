// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:petai/models/pet.dart';
// import 'package:petai/view_models/ai_controller.dart';
// import 'package:petai/view_models/home_controller.dart';
// import 'package:petai/view_models/image_controller.dart';
// import 'package:petai/view_models/pet_controller.dart';
// import 'package:petai/views/pages/analysis_result_page.dart';
// import 'package:petai/views/widgets/image_widget.dart';
// import 'package:petai/views/widgets/loader.dart';

// class GetPetInfoPage extends StatelessWidget {
//   const GetPetInfoPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final petController = Get.find<PetController>();
//     final petNameController = TextEditingController();
//     final petBreedController = TextEditingController();
//     final petAgeController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pet Info'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ItemImageView(
//               bytes: Get.find<ImageController>().imageToAnalyze,
//             ),
//             TextField(
//               controller: petNameController,
//               decoration: const InputDecoration(labelText: 'Pet Name'),
//             ),
//             TextField(
//               controller: petBreedController,
//               decoration: const InputDecoration(labelText: 'Pet Breed'),
//             ),
//             TextField(
//               controller: petAgeController,
//               decoration: const InputDecoration(labelText: 'Pet Age'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 showLoadingDialog();
//                 final pet = Pet(
//                   image: Get.find<ImageController>().imageToAnalyze,
//                   name: petNameController.text,
//                   breed: petBreedController.text,
//                   age: petAgeController.text,
//                 );
//                 petController.setCurrentPet(pet);
//                 Get.find<HomeController>().addPet(pet);
//                 Get.find<AIController>().generateContent(
//                   pet.toString(),
//                   pet.image!,
//                 );
//                 Get.to(() => PetAnalysis());
//               },
//               child: Text('analyze'.tr),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
