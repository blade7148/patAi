// create an instance of HiveService then use everywhere
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  late Box _box;

  Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    _box = await Hive.openBox('hiveBox');
  }

  Future<void> writeData(String key, dynamic value) async {
    await _box.put(key, value);
  }

  dynamic readData(String key) {
    return _box.get(key);
  }

  Future<void> deleteData(String key) async {
    await _box.delete(key);
  }

  Future<void> clearData() async {
    await _box.clear();
  }
}

extension UserHiveService on HiveService {
  bool get isWelcomeShowed => readData('welcomeShowed') ?? false;

  Future<void> onWelcomeShowed() async {
    await writeData('welcomeShowed', true);
  }
}
