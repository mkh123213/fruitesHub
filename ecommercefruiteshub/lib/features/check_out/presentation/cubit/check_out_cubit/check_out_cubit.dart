import 'package:ecommercefruiteshub/core/entities/order_entity.dart';
import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';
import 'package:ecommercefruiteshub/features/check_out/domain/use_cases/add_order_to_databse_use_case.dart';
import 'package:ecommercefruiteshub/features/profile/domain/use_cases/get_orders_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit({required this.addOrderUseCase}) : super(CheckOutInitial());
  final AddOrderToDatabseUseCase addOrderUseCase;

  int currentStep = 0;
  final bool choosePaymentMethod = false;
  // bool readyToPay = false;
  bool changeAddress = false;

  void changeAddressMethod() {
    changeAddress = !changeAddress;
    emit(ConfirmChangeAddress());
  }

  Future<void> addOrder({required OrderInputEntity order}) async {
    emit(AddOrderLoading());
    final result = await addOrderUseCase.call(order: order);
    result.fold(
      (failure) => emit(AddOrderFailure(message: failure.message)),
      (products) => emit(AddOrderSuccess()),
    );
  }
}
