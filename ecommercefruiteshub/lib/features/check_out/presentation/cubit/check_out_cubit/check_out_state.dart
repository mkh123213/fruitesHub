part of 'check_out_cubit.dart';

sealed class CheckOutState {}

final class CheckOutInitial extends CheckOutState {}

final class ChoosePaymentMethod extends CheckOutState {}

final class ConfirmChangeAddress extends CheckOutState {}

final class AddOrderLoading extends CheckOutState {}

final class AddOrderFailure extends CheckOutState {
  final String message;
  AddOrderFailure({required this.message});
}

final class AddOrderSuccess extends CheckOutState {}
