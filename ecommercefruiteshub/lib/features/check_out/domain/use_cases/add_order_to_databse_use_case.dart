import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/core/entities/order_entity.dart';
import 'package:ecommercefruiteshub/features/check_out/domain/repo_interface/order_repo_interface.dart';

class AddOrderToDatabseUseCase {
  final CheckOutRepoInterface repo;
  AddOrderToDatabseUseCase({required this.repo});

  Future<Either<Failure, void>> call({required OrderInputEntity order}) {
    return repo.addOrder(order: order);
  }
}
