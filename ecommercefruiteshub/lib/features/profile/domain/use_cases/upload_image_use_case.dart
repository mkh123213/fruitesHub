import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/profile/domain/repo_interface/maim_profile_repo_interface.dart';

class UploadImageUseCase {
  final MainProfileRepoInterface repo;

  UploadImageUseCase({required this.repo});

  Future<Either<Failure, String>> call({
    required File fileToUpload,
    required String fileName,
  }) {
    return repo.uploadImage(fileToUpload: fileToUpload, fileName: fileName);
  }
}
