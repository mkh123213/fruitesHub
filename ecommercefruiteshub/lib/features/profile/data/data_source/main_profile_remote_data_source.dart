import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/connection/network_info.dart';
import 'package:ecommercefruiteshub/core/errors/exceptions.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/core/helper_functions/get_user.dart';
import 'package:ecommercefruiteshub/core/models/order_model.dart';

import 'package:ecommercefruiteshub/core/services/data_storage/data_storage.dart';
import 'package:ecommercefruiteshub/core/services/auth_service.dart';
import 'package:ecommercefruiteshub/core/services/firestore_service.dart';
import 'package:ecommercefruiteshub/core/utils/api_path.dart';
import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainProfileRemoteDataSource {
  final NetworkInfo networkInfo;
  final DataStorage dataStorage;
  final DataBaseService dataBase;
  final AuthService authService;
  MainProfileRemoteDataSource({
    required this.authService,
    required this.networkInfo,
    required this.dataStorage,
    required this.dataBase,
  });

  Future<String> uploadImage({
    required File fileToUpload,
    required String fileName,
  }) async {
    try {
      final result = await dataStorage.setData(
        key: fileName,
        fileToSave: fileToUpload,
      );
      return result;
    } on StorageException catch (e) {
      switch (e.statusCode) {
        case "409":
          throw CustomException(message: "image already used ${e.message}");

        default:
          throw CustomException(message: "error in uploading image");
      }
    }
  }

  Future<Either<Failure, void>> updateNameAndEmail({
    required String name,
    required String email,
    required String currentPassword,
  }) async {
    if (await networkInfo.isConnected == true) {
      try {
        await authService.updateUserNameAndEmail(
          name: name,
          email: email,
          currentPassword: currentPassword,
        );

        return Right(unit);
      } on CustomException catch (e) {
        throw CustomException(message: e.message);
      }
    } else {
      throw CustomException(message: 'No internet connection');
    }
  }

  Future<Either<Failure, Unit>> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    if (await networkInfo.isConnected == true) {
      try {
        await authService.updatePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
        );
        return Right(unit);
      } on CustomException catch (e) {
        throw CustomException(message: e.message);
      }
    } else {
      throw CustomException(message: 'No internet connection');
    }
  }

  Future<List<OrderTrack>> getOrderTrack() async {
    int counter = 0;
    if (await networkInfo.isConnected == true) {
      try {
        final ls = await dataBase.getCollection<OrderModel>(
          path: ApiPath.getOrderTrack(orderIdOrUserId: getUser().uid),
          builder: (query, documentId) {
            return OrderModel.fromJson(query);
          },
        );
        return ls.map((e) => e.toTrack()).toList();
      } catch (e) {
        throw CustomException(message: e.toString());
      }
    } else {
      throw CustomException(message: 'No internet connection');
    }
  }

  Future<void> changeProfilePicture({required String profileImgUrl}) async {
    if (await networkInfo.isConnected == true) {
      try {
        authService.changeProfilePicture(profileImgUrl: profileImgUrl);
      } catch (e) {
        throw CustomException(message: e.toString());
      }
    } else {
      throw CustomException(message: 'No internet connection');
    }
  }
}
