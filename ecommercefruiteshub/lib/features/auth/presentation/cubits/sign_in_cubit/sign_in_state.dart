part of 'sign_in_cubit.dart';

sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInWithGoogleLoading extends SignInState {}

final class SignInWithGoogleSuccess extends SignInState {
  final User user;
  SignInWithGoogleSuccess(this.user);
}

final class SignInWithGoogleError extends SignInState {
  late final String errMessage;
  SignInWithGoogleError({required this.errMessage});
}

final class SignInWithEmailAndPasswordLoading extends SignInState {}

final class SignInWithEmailAndPasswordSuccess extends SignInState {
  final UserEntity user;
  SignInWithEmailAndPasswordSuccess({required this.user});
}

final class SignInWithEmailAndPasswordFailure extends SignInState {
  final String message;
  SignInWithEmailAndPasswordFailure({required this.message});
}
