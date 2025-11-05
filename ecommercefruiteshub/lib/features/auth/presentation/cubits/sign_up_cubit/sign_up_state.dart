part of 'sign_up_cubit.dart';

sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class CheckBoxState extends SignUpState {}

final class SignUpWithEmailAndPasswordLoading extends SignUpState {}

final class SignUpWithEmailAndPasswordFailure extends SignUpState {
  final String message;
  SignUpWithEmailAndPasswordFailure(this.message);
}

final class SignUpWithEmailAndPasswordSuccess extends SignUpState {
  final UserEntity user;
  SignUpWithEmailAndPasswordSuccess({required this.user});
}
