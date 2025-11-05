import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/core/services/auth_service.dart';
import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:ecommercefruiteshub/features/auth/domain/repo_interface/auth_repo_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithGoogleUseCase {
  final AuthRepoInterface repo;
  SignInWithGoogleUseCase(this.repo);
  Future<Either<Failure, User>> call() async {
    return repo.signInWithGoogle();
  }
}
