import 'package:ecommercefruiteshub/features/auth/data/models/user_model.dart';
import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:ecommercefruiteshub/features/auth/domain/use_cases/sign_in_with_email_and_password.dart';
import 'package:ecommercefruiteshub/features/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.signInWithGoogleUseCase,
    required this.signInWithEmailAndPassword,
  }) : super(SignInInitial());

  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignInWithEmailAndPasswordUseCase signInWithEmailAndPassword;

  Future<void> signInWithGoogle() async {
    emit(SignInWithGoogleLoading());
    final result = await signInWithGoogleUseCase.call();
    result.fold(
      (failure) => emit(SignInWithGoogleError(errMessage: failure.message)),
      (user) {
        emit(SignInWithGoogleSuccess(user));
      },
    );
  }

  Future<void> signInWithEmailAndPassWord({
    required String email,
    required String password,
  }) async {
    emit(SignInWithEmailAndPasswordLoading());
    final result = await signInWithEmailAndPassword.call(
      email: email,
      password: password,
    );
    result.fold(
      (failure) =>
          emit(SignInWithEmailAndPasswordFailure(message: failure.message)),
      (user) {
        emit(
          SignInWithEmailAndPasswordSuccess(user: UserModel.fromFierBase(user)),
        );
      },
    );
  }
}
