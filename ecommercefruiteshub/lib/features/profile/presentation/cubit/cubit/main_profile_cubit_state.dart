part of 'main_profile_cubit.dart';

sealed class MainProfileState {}

final class AddProductCubitInitial extends MainProfileState {}

final class EditNameAndEmailFileds extends MainProfileState {}

final class EditPassWord extends MainProfileState {}

final class UpdateNameAndEmailLoading extends MainProfileState {}

final class UpdateNameAndEmailError extends MainProfileState {
  final String message;
  UpdateNameAndEmailError({required this.message});
}

final class UpdateNameAndEmailSuccess extends MainProfileState {}

final class LoadingImgStart extends MainProfileState {}

final class LoadingImgSUccess extends MainProfileState {
  final String imageUrl;
  LoadingImgSUccess({required this.imageUrl});
}

final class LoadingImgError extends MainProfileState {
  final String message;
  LoadingImgError({required this.message});
}

final class SaveProfilPIctureUrlSuccess extends MainProfileState {
  final String imageUrl;
  SaveProfilPIctureUrlSuccess({required this.imageUrl});
}

final class SaveProfilPIctureUrlFailure extends MainProfileState {
  final String message;
  SaveProfilPIctureUrlFailure({required this.message});
}

final class UpdatePasswordLoading extends MainProfileState {}

final class UpdatePasswordError extends MainProfileState {
  final String message;
  UpdatePasswordError({required this.message});
}

final class UpdatePasswordSuccess extends MainProfileState {}

final class OrderTrackLoading extends MainProfileState {}

final class OrderTrackLoaded extends MainProfileState {
  final List<OrderTrack> ordersTrackEntity;
  OrderTrackLoaded({required this.ordersTrackEntity});
}

final class OrderTrackFailure extends MainProfileState {
  final String message;
  OrderTrackFailure({required this.message});
}

final class OrderTrackEmpty extends MainProfileState {}
