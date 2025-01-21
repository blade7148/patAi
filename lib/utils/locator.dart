import 'package:get_it/get_it.dart';
import 'package:petai/utils/services/image_service.dart';

GetIt appLocator = GetIt.instance;

Future<void> setupServices() async {
  appLocator.registerLazySingleton(() => ImageService());
}
