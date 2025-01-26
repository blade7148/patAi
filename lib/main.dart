import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petai/firebase_options.dart';
import 'package:petai/utils/binding.dart';
import 'package:petai/utils/languages/language.dart';
import 'package:petai/utils/languages/util.dart';
import 'package:petai/utils/locator.dart';
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
