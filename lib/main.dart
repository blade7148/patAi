import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petai/firebase_options.dart';
import 'package:petai/utils/binding.dart';
import 'package:petai/utils/languages/language.dart';
import 'package:petai/utils/languages/util.dart';
import 'package:petai/utils/locator.dart';
import 'package:petai/utils/services/firestore_service.dart';
import 'package:petai/utils/services/hive_service.dart';
import 'package:petai/views/pages/home_page.dart';
import 'package:petai/views/pages/onboarding/welcome_page_1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServices();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  await HiveService().init();
  await FireStoreService().printData();

  Gemini.init(
    apiKey: const String.fromEnvironment('apiKey'),
    enableDebugging: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pet AI',
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      theme: ThemeData(
        // scaffoldBackgroundColor: const Color.fromARGB(255, 247, 247, 247),
        primarySwatch: Colors.blue,
        fontFamily: 'Outfit',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.orange),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: (HiveService().isWelcomeShowed)
          ? const HomePage()
          : const WelcomePage1(),
      initialBinding: MainBinding(),
      translations: Languages(),
      locale: Locale(GetStorage().read<String>("language") ?? getCountryCode()),
      fallbackLocale: Locale(
        getLanguageCode(),
        getCountryCode(),
      ),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Your JSON data
//     final petData = {
//       "define": {
//         "breed": "Golden Retriever",
//         "age": "5 years",
//         "characteristics": {
//           "unique_features": ["Loyal", "Friendly", "Active"]
//         }
//       },
//       "check": {
//         "medical_conditions": ["Arthritis", "Allergy to certain foods"]
//       }
//     };

//     return MaterialApp(
//       home: PetAnalysis(petData: petData),
//     );
//   }
// }

// class PetAnalysis extends StatelessWidget {
//   final Map<String, dynamic> petData;

//   const PetAnalysis({Key? key, required this.petData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header
//                 Row(
//                   children: [
//                     Icon(Icons.arrow_back, color: Colors.grey),
//                     SizedBox(width: 8),
//                     Text(
//                       petData['define']['breed'],
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Text('Pet • ${petData['define']['breed']}',
//                     style: TextStyle(color: Colors.grey)),
//                 SizedBox(height: 16),

//                 // Tags
//                 Wrap(
//                   spacing: 8,
//                   children: [
//                     _buildTag(Icons.pets, 'Medium Care'),
//                     _buildTag(null, 'Medium'),
//                   ],
//                 ),
//                 SizedBox(height: 16),

//                 // Alert
//                 _buildAlertCard(),
//                 SizedBox(height: 16),

//                 // About section
//                 _buildSectionCard(
//                     'About',
//                     '${petData['define']['characteristics']['unique_features'].join(', ')}. '
//                         '${petData['define']['breed']}s are known for their '
//                         '${petData['define']['characteristics']['unique_features'][0].toLowerCase()} '
//                         'nature and make excellent family pets.'),
//                 SizedBox(height: 16),

//                 // Details section
//                 _buildDetailsCard(),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: _buildBottomButton(),
//     );
//   }

//   Widget _buildTag(IconData? icon, String text) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (icon != null) ...[
//             Icon(icon, size: 16),
//             SizedBox(width: 4),
//           ],
//           Text(text, style: TextStyle(fontSize: 12)),
//         ],
//       ),
//     );
//   }

//   Widget _buildAlertCard() {
//     return Card(
//       color: Colors.red[50],
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.warning, color: Colors.red),
//                 SizedBox(width: 8),
//                 Text('Your pet may need attention!',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ],
//             ),
//             SizedBox(height: 8),
//             Text('Regular check-ups are important for your pet\'s health.'),
//             SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () {},
//               child: Text('Get More Info'),
//               style: ElevatedButton.styleFrom(primary: Colors.red),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionCard(String title, String content) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text(content),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailsCard() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Details',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 16),
//             _buildDetailRow(
//                 Icons.thermostat, 'Temperature', 'Keep between 20°C-25°C'),
//             _buildDetailRow(Icons.wb_sunny, 'Sunlight', 'Moderate sunlight'),
//             _buildDetailRow(Icons.water_drop, 'Water', 'Every 1-2 days'),
//             _buildDetailRow(Icons.content_cut, 'Grooming', 'Every 4-6 weeks'),
//             _buildDetailRow(Icons.restaurant, 'Food',
//                 'High-quality dog food appropriate for ${petData['define']['age']} old ${petData['define']['breed']}'),
//             _buildDetailRow(Icons.bug_report, 'Common Issues',
//                 petData['check']['medical_conditions'].join(', ')),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(IconData icon, String title, String description) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 24, color: Colors.green),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//                 SizedBox(height: 4),
//                 Text(description),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomButton() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: ElevatedButton(
//         onPressed: () {},
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.add_a_photo),
//             SizedBox(width: 8),
//             Text('Add to My Pets'),
//           ],
//         ),
//         style: ElevatedButton.styleFrom(
//           primary: Colors.green,
//           padding: EdgeInsets.symmetric(vertical: 16),
//         ),
//       ),
//     );
//   }
// }
