import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.name, required super.uid});

  factory UserModel.fromFierBase(User user) {
    return UserModel(
      email: user.email ?? '',
      name: user.displayName ?? '',
      uid: user.uid,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      uid: json['uid'],
    );
  }
  factory UserModel.fromEntity({required UserEntity user}) {
    return UserModel(email: user.email, name: user.name, uid: user.uid);
  }

  toMap() {
    return {'email': email, 'name': name, 'uid': uid};
  }
}
