import 'dart:io';

abstract class DataStorage {
  Future<String> setData({required String key, required File fileToSave});
}
