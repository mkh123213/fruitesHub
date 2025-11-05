import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepoInterface {
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, User>> signInWithGoogle();
  Future<Either<Failure, User>> signInWithFacebook();
  Future<Either<Failure, User>> signInWithApple();

  Future<Either<Failure, void>> addUser({required UserEntity user});

  Future<Either<Failure, void>> deleteUser({required UserEntity user});
  Future<Either<Failure, void>> saveUser({required UserEntity user});
}
