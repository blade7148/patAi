import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petai/firebase_options.dart';
import 'package:petai/utils/binding.dart';
import 'package:petai/utils/languages/language.dart';
import 'package:petai/utils/languages/util.dart';
import 'package:petai/utils/locator.dart';
import 'package:petai/utils/observer.dart';
import 'package:petai/utils/services/hive_service.dart';
import 'package:petai/views/pages/home_page.dart';
import 'package:petai/views/pages/onboarding/welcome_page_1.dart';
import 'package:petai/views/pages/analysis_result_page.dart';

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
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Pet AI',
          navigatorObservers: [MyObserver(), FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF7F7F7),
            primarySwatch: Colors.blue,
            fontFamily: 'Outfit',
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              errorStyle: const TextStyle(height: 0),
              border: defaultInputBorder,
              enabledBorder: defaultInputBorder,
              focusedBorder: defaultInputBorder.copyWith(
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              errorBorder: defaultInputBorder.copyWith(
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
            textTheme: TextTheme(
              displayLarge:
                  TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
              displayMedium:
                  TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              displaySmall:
                  TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              headlineLarge:
                  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              headlineMedium:
                  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              headlineSmall:
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              titleLarge:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              titleMedium:
                  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              titleSmall:
                  TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              primary: Colors.blue,
              secondary: Colors.orange,
            ),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: HiveService().isWelcomeShowed ? '/home' : '/welcome',
          getPages: [
            GetPage(name: '/home', page: () => const HomePage()),
            GetPage(name: '/welcome', page: () => const WelcomePage1()),
            GetPage(name: '/analysis', page: () => const PetAnalysis()),
          ],
          initialBinding: MainBinding(),
          translations: Languages(),
          locale:
              Locale(GetStorage().read<String>("language") ?? getCountryCode()),
          fallbackLocale: Locale(
            getLanguageCode(),
            getCountryCode(),
          ),
        );
      },
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
