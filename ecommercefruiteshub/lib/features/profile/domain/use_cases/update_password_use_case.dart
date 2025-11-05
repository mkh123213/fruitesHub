import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/profile/domain/repo_interface/maim_profile_repo_interface.dart';

class UpdatePasswordUseCase {
  final MainProfileRepoInterface repo;

  UpdatePasswordUseCase({required this.repo});

  Future<Either<Failure, Unit>> call({
    required String oldPassword,
    required String newPassword,
  }) {
    return repo.updatePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
