import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  late Box<String> _mediaBox;
  late Box<String> _settingBox;
  bool _isInitiazed = false;

  // this function intialiazed hive database using .initFlutter method
  // is specific to flutter only.
  // Hive is key/valye based database. So we are excepected to
  // provide data in the key/value form.
  Future<bool> intializeHiveDB(String path) async {
    await Hive.initFlutter(path);
    _settingBox = await Hive.openBox<String>("settings");
    _mediaBox = await Hive.openBox<String>("media");
    _isInitiazed = true;

    String? result = _settingBox.get("initiazed");
    if (result == null) {
      return false;
    } else {
      return true;
    }
  }

  // function for setting values in database
  void set(String boxName, String key, dynamic value) {
    if (!_isInitiazed) {
      throw Exception("Hive Database is not yet initiazed");
    } else {
      if (boxName == "settings") {
        _settingBox.put(key, value);
      } else if (boxName == "media") {
        _mediaBox.put(key, value);
      }
    }
  }

  // function for getting values from the database.
  String? get(String boxName, String key) {
    if (!_isInitiazed) {
      throw Exception("Hive Database is not yet initiazed");
    } else {
      if (boxName == "settings") {
        return _settingBox.get(key);
      } else {
        return _mediaBox.get(key);
      }
    }
  }
}