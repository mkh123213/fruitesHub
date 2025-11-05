// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/exceptions.dart';

import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/profile/data/data_source/main_profile_remote_data_source.dart';
import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';
import 'package:ecommercefruiteshub/features/profile/domain/repo_interface/maim_profile_repo_interface.dart';

class MainProfileRepoImpl implements MainProfileRepoInterface {
  final MainProfileRemoteDataSource remoteDataSource;
  MainProfileRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, String>> uploadImage({
    required File fileToUpload,
    required String fileName,
  }) async {
    try {
      final result = await remoteDataSource.uploadImage(
        fileToUpload: fileToUpload,
        fileName: fileName,
      );
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNameAndEmail({
    required String name,
    required String email,
    required String currentPassword,
  }) async {
    try {
      await remoteDataSource.updateNameAndEmail(
        name: name,
        email: email,
        currentPassword: currentPassword,
      );
      return Right(unit);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      remoteDataSource.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return Right(unit);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderTrack>>> getOrderTrack() async {
    try {
      final ordeerTrack = await remoteDataSource.getOrderTrack();
      return Right(ordeerTrack);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
