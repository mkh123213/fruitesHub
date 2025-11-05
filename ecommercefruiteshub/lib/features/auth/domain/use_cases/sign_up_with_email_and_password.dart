import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/core/services/auth_service.dart';
import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:ecommercefruiteshub/features/auth/domain/repo_interface/auth_repo_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepoInterface repo;
  SignUpWithEmailAndPasswordUseCase(this.repo);
  Future<Either<Failure, User>> call({
    required String email,
    required String password,
    required String name,
  }) async {
    return repo.createUserWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
    );
  }
}
