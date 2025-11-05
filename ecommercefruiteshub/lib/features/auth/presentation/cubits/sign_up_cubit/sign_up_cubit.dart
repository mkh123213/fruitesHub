import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommercefruiteshub/features/auth/data/models/user_model.dart';
import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:ecommercefruiteshub/features/auth/domain/use_cases/sign_up_with_email_and_password.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.signUpWithEmailAndPasswordUseCase})
    : super(SignUpInitial());
  final SignUpWithEmailAndPasswordUseCase signUpWithEmailAndPasswordUseCase;
  late bool isChecked = false;
  Future<void> signUpWithEmailAndPassWord({
    required String email,
    required String password,
    required String name,
  }) async {
    if (isChecked) {
      emit(SignUpWithEmailAndPasswordLoading());
      final result = await signUpWithEmailAndPasswordUseCase.call(
        email: email,
        password: password,
        name: name,
      );
      result.fold(
        (failure) => emit(SignUpWithEmailAndPasswordFailure(failure.message)),
        (user) {
          print("############################ok#####################");
          emit(
            SignUpWithEmailAndPasswordSuccess(
              user: UserModel.fromFierBase(user).copyWith(name: name),
            ),
          );
        },
      );
    } else {
      emit(
        SignUpWithEmailAndPasswordFailure(
          'Please accept the terms and conditions',
        ),
      );
    }
  }
}
