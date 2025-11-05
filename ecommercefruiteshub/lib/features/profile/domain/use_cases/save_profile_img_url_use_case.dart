import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/profile/domain/repo_interface/maim_profile_repo_interface.dart';

class ChangeProfilePictureUseCase {
  final MainProfileRepoInterface repo;
  ChangeProfilePictureUseCase({required this.repo});

  Future<Either<Failure, Unit>> call({required String profileImgUrl}) {
    return repo.changeProfilePicture(profileImgUrl: profileImgUrl);
  }
}
