import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';

abstract class MainProfileRepoInterface {
  Future<Either<Failure, String>> uploadImage({
    required File fileToUpload,
    required String fileName,
  });

  Future<Either<Failure, Unit>> updateNameAndEmail({
    required String name,
    required String email,
    required String currentPassword,
  });

  Future<Either<Failure, Unit>> updatePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<Either<Failure, List<OrderTrack>>> getOrderTrack();

  Future<Either<Failure, Unit>> changeProfilePicture({
    required String profileImgUrl,
  });
}
