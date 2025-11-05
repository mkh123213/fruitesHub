import 'dart:convert';

import 'package:ecommercefruiteshub/core/services/shared_preferences_singleton.dart';
import 'package:ecommercefruiteshub/core/utils/constants.dart';
import 'package:ecommercefruiteshub/features/auth/data/models/user_model.dart';
import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

UserEntity getUser() {
  var jsonString = Prefs.getString(kUserData);
  var userEntity = UserModel.fromJson(
    jsonDecode(jsonString),
  ).copyWith(profilePicture: FirebaseAuth.instance.currentUser?.photoURL ?? "");
  return userEntity;
}
