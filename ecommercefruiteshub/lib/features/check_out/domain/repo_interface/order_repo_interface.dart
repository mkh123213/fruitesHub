import 'package:dartz/dartz.dart';
import 'package:ecommercefruiteshub/core/errors/failures.dart';
import 'package:ecommercefruiteshub/core/entities/order_entity.dart';

abstract class CheckOutRepoInterface {
  Future<Either<Failure, void>> addOrder({required OrderInputEntity order});
}
