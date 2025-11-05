import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/auth/domain/repo_interface/auth_repo_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepoInterface repo;
  SignInWithEmailAndPasswordUseCase({required this.repo});

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    return repo.signInWithEmailAndPassword(email: email, password: password);
  }
}
