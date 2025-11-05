import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/helper_functions/get_user.dart';
import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';
import 'package:ecommercefruiteshub/features/profile/domain/use_cases/save_profile_img_url_use_case.dart';
import 'package:ecommercefruiteshub/features/profile/domain/use_cases/update_name_and_email_use_case.dart';
import 'package:ecommercefruiteshub/features/profile/domain/use_cases/update_password_use_case.dart';
import 'package:ecommercefruiteshub/features/profile/domain/use_cases/upload_image_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommercefruiteshub/features/profile/domain/use_cases/get_orders_use_case.dart';
part 'main_profile_cubit_state.dart';

class MainProfileCubit extends Cubit<MainProfileState> {
  MainProfileCubit({
    required this.changeProfilePictureUseCase,
    required this.getOrderTrackUseCase,
    required this.updatePasswordUseCase,
    required this.updateNameAndEmailUseCase,
    required this.uploadImageUseCase,
  }) : super(AddProductCubitInitial());
  final UploadImageUseCase uploadImageUseCase;
  final UpdateNameAndEmailUseCase updateNameAndEmailUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final GetOrdersTrackUseCase getOrderTrackUseCase;
  final ChangeProfilePictureUseCase changeProfilePictureUseCase;
  bool editNameAndEmailFileds = true;
  bool editPassword = true;
  Future<void> uploadImage({
    required File fileToUpload,
    required String fileName,
  }) async {
    print("uploading image");
    emit(LoadingImgStart());

    final result = await uploadImageUseCase.call(
      fileToUpload: fileToUpload,
      fileName: fileName,
    );
    result.fold(
      (l) {
        print("uploading image error ${l.message}");

        emit(LoadingImgError(message: l.message));
      },
      (r) {
        _foldSaveUrl(imageUrl: r);

        emit(LoadingImgSUccess(imageUrl: r));
      },
    );
  }

  void toggelLanguage({required BuildContext context}) {
    if (context.locale.languageCode == "en") {
      context.setLocale(const Locale("ar"));
    } else {
      context.setLocale(const Locale("en"));
    }
  }

  void toggelNameAndEmailFileds() {
    editNameAndEmailFileds = !editNameAndEmailFileds;
    emit(EditNameAndEmailFileds());
  }

  void toggelPassword() {
    editPassword = !editPassword;

    emit(EditPassWord());
  }

  Future<void> updateNameAndEmail({
    required String name,
    required String email,
    required String currentPassword,
  }) async {
    emit(UpdateNameAndEmailLoading());
    final result = await updateNameAndEmailUseCase.call(
      name: name,
      email: email,
      currentPassword: currentPassword,
    );
    result.fold(
      (l) {
        emit(UpdateNameAndEmailError(message: l.message));
      },
      (r) {
        emit(UpdateNameAndEmailSuccess());
      },
    );
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(UpdatePasswordLoading());
    final result = await updatePasswordUseCase.call(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    result.fold(
      (l) {
        emit(UpdatePasswordError(message: l.message));
      },
      (r) {
        emit(UpdatePasswordSuccess());
      },
    );
  }

  Future<void> getOrderTrack() async {
    emit(OrderTrackLoading());
    final result = await getOrderTrackUseCase.call();
    result.fold(
      (failure) => emit(OrderTrackFailure(message: failure.message)),
      (orders) {
        if (orders.isEmpty) {
          emit(OrderTrackEmpty());
        } else {
          emit(OrderTrackLoaded(ordersTrackEntity: orders));
        }
      },
    );
  }

  Future<void> _foldSaveUrl({required String imageUrl}) async {
    final result = await changeProfilePictureUseCase.call(
      profileImgUrl: imageUrl,
    );
    result.fold(
      (failure) => emit(SaveProfilPIctureUrlFailure(message: failure.message)),
      (r) {
        getUser().copyWith(profilePicture: imageUrl);

        emit(SaveProfilPIctureUrlSuccess(imageUrl: imageUrl));
      },
    );
  }
}
