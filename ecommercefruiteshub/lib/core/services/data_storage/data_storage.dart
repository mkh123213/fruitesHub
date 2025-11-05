import 'dart:io';

import 'package:dartz/dartz.dart';

abstract class DataStorage {
  Future<String> setData({required String key, required File fileToSave});
}
