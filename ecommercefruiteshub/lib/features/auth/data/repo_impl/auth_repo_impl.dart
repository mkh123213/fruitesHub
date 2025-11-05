import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/errors/exceptions.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/core/services/auth_service.dart';
import 'package:ecommercefruiteshub/core/services/firestore_service.dart';
import 'package:ecommercefruiteshub/core/services/shared_preferences_singleton.dart';
import 'package:ecommercefruiteshub/core/utils/api_path.dart';
import 'package:ecommercefruiteshub/core/utils/constants.dart';
import 'package:ecommercefruiteshub/features/auth/data/models/user_model.dart';
import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:ecommercefruiteshub/features/auth/domain/repo_interface/auth_repo_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepoInterface {
  final AuthService authServiceInstance;
  final DataBaseService dataBaseSeviceInstance;
  AuthRepoImpl({
    required this.authServiceInstance,
    required this.dataBaseSeviceInstance,
  });
  @override
  Future<Either<Failure, User>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await authServiceInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final isExistInFierStoreDB = await checkIfUserExists(
        user: UserModel.fromFierBase(user),
      );

      if (!isExistInFierStoreDB) {
        print("not exist");
        final result = await addUser(
          user: UserEntity(email: email, name: name, uid: user.uid),
        );

        result.fold(
          (l) {
            print("error to add###########");
            deleteUser(user: UserModel.fromFierBase(user));
            throw CustomException(message: "error_adding_user".tr());
          },
          (r) {
            print("added  ###########");
            Prefs.setBool("isLogin", true);
            Prefs.setString("userId", user.uid);
            return Right(user);
          },
        );
      } else {
        print("exist");
      }

      return Right(user);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authServiceInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final isExistInFierStoreDB = await checkIfUserExists(
        user: UserModel.fromFierBase(user),
      );
      if (!isExistInFierStoreDB) {
        throw CustomException(
          message:
              "there_is_an_error_while_adding_you_to_DB_please_contact_support",
        );
      }

      return Right(user);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final user = await authServiceInstance.signInWithGoogle();
      final isExistInFierStoreDB = await checkIfUserExists(
        user: UserModel.fromFierBase(user),
      );

      if (!isExistInFierStoreDB) {
        print("not exist");
        final result = await addUser(user: UserModel.fromFierBase(user));

        result.fold(
          (l) {
            print("error to add###########");
            deleteUser(user: UserModel.fromFierBase(user));
            throw CustomException(message: "error_adding_user".tr());
          },
          (r) {
            print("added  ###########");

            return Right(user);
          },
        );
      } else {
        print("exist");
      }
      Prefs.setBool("isLogin", true);
      return Right(user);
    } catch (e) {
      log("Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}");
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addUser({required UserEntity user}) async {
    try {
      await dataBaseSeviceInstance.setData(
        path: ApiPath.users(userId: user.uid),
        data: UserModel.fromEntity(user: user).toMap(),
      );
      saveUser(user: user);
      return const Right(null);
    } catch (e) {
      log("Exception in AuthRepoImpl.addUser: ${e.toString()}");
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser({required UserEntity user}) async {
    try {
      await dataBaseSeviceInstance.deleteData(
        path: ApiPath.users(userId: user.uid),
      );
      return const Right(null);
    } catch (e) {
      log("Exception in AuthRepoImpl.deleteUser: ${e.toString()}");
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<bool> checkIfUserExists({required UserEntity user}) async {
    try {
      await dataBaseSeviceInstance.getDocument(
        path: ApiPath.users(userId: user.uid),
        builder: (data, documentID) async {
          await saveUser(user: UserModel.fromJson(data));
          return UserModel.fromJson(data);
        },
      );
      return true;
    } catch (e) {
      log("Exception in AuthRepoImpl.checkIfUserExists: ${e.toString()}");
      return false;
    }
  }

  @override
  Future<Either<Failure, void>> saveUser({required UserEntity user}) async {
    try {
      await Prefs.setString(
        kUserData,
        jsonEncode(UserModel.fromEntity(user: user).toMap()),
      );
      return const Right(null);
    } catch (e) {
      // TODO
      throw CustomException(message: "unable to add user to phone storage");
    }
  }
}
